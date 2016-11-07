//
//  LoginViewModel.swift
//  Luna
//
//  Created by Erika Wilcox on 9/24/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation

class LoginViewModel
{
	// MARK: Public API
	//
	
	init( withAuthService authService: ServiceAuthenticatable, dbService: ServiceDBManageable )
	{
		self.authService = authService
		self.dbService = dbService
	}
	
	func loginAsync(_ credentials: Credentials, completion: @escaping(_ error: Error? ) -> Void )
	{
		// Put network request on background thread.
		//
		DispatchQueue.global( qos: .userInitiated ).async
		{
			self.lunaAPI.login( credentials )
			{
				[weak self] innerThrows in
				guard let strongSelf = self else { return }
				
				do
				{
					let token = try innerThrows()
					strongSelf.authService.signInUser( withToken: token )
					{
						uidOrNil, errorOrNil in
						
						strongSelf.dbService.createUserRecord( forUid: uidOrNil, username: credentials.username )
						completion( errorOrNil )
					}
				}
				catch
				{
					completion( error )
				}
			}
		}
	}    
	
	// MARK: Implementation Details
	//
	
	fileprivate let lunaAPI = LunaAPI( requestor: LunaRequestor() )
	fileprivate let authService: ServiceAuthenticatable!
	fileprivate let dbService: ServiceDBManageable!
}
