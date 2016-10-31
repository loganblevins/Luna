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
	init( withAuthService authService: ServiceAuthenticatable, databaseService: ServiceDBManageable )
	{
		self.authService = authService
		self.databaseService = databaseService
	}
	
	func loginAsync(_ credentials: Credentials, completion: @escaping(_ error: Error? ) -> Void )
	{
		// Put network request on background thread.
		//
		DispatchQueue.global( qos: .userInitiated ).async
		{
			DispatchQueue.main.async
			{
				showNetworkActivity( show: true )
			}
			
			let lunaAPI = LunaAPI( requestor: LunaRequestor() )
			lunaAPI.login( credentials )
			{
				[weak self] innerThrows in
				guard let strongSelf = self else { return }
				
				do
				{
					let token = try innerThrows()
					strongSelf.authService.signInUser( withToken: token )
					{
						error in
						
						completion( error )
					}
				}
				catch
				{
					completion( error )
				}
			}
			
			defer
			{
				DispatchQueue.main.async
				{
					showNetworkActivity( show: false )
				}
			}
		}
	}

    
//    func anonymousAuth ()
//    {
//        userService.firebaseAuthAnonymous(){
//            (res) in
//            
//            self.anonymousID = res!
//        }
//    }
	
//    func loginUser( _ username: String, userpassword: String, completion: ((_ result:Bool?) -> Void)!)
//    {
//        userService.loginUser(userid: anonymousID, username: username, userpassword: userpassword) { (res) in
//            if (res)!
//            {
//                print ("yes")
//                completion(true)
//            }
//            else
//            {
//                print ("no")
//                completion(false)
//            }
//        }
//    }
//    
	
	fileprivate let authService: ServiceAuthenticatable!
	fileprivate let databaseService: ServiceDBManageable!
}
