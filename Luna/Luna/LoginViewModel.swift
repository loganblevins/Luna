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
						
						strongSelf.onAuthServiceSignInAttempt( uidOrNil, username: credentials.username, password: credentials.password )
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
	
	fileprivate func onAuthServiceSignInAttempt(_ uid: String?, username: String, password: String )
	{
		guard let uid = uid else { return }
		self.dbService.createUserRecord( forUid: uid, username: username )
		persistUserToDisk( forUid: uid, username: username, password: password )
	}
	
	fileprivate func persistUserToDisk( forUid uid: String, username: String, password: String )
	{
		StandardDefaults.sharedInstance.uid = uid
		StandardDefaults.sharedInstance.username = username
		StandardDefaults.sharedInstance.password = password
	}
	
	// MARK: Implementation Details
	//
	
	fileprivate let lunaAPI = LunaAPI( requestor: LunaRequestor() )
	fileprivate let authService: ServiceAuthenticatable!
	fileprivate let dbService: ServiceDBManageable!
}
