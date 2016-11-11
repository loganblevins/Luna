//
//  SettingsViewModel.swift
//  Luna
//
//  Created by Logan Blevins on 11/3/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation

class SettingsViewModel
{
	// MARK: Public API
	//
	
	init( withAuthService authService: ServiceAuthenticatable, databaseService: ServiceDBManageable )
	{
		self.authService = authService
		self.databaseService = databaseService
	}
	
	func logout() throws
	{
		try authService.signOutUser()
	}
	
	func deleteAccountAsync( completion: @escaping(_ error: Error? ) -> Void )
	{
		DispatchQueue.global( qos: .userInitiated ).async
		{			
			// Delete user in Firebase.
			//
			guard let uid = StandardDefaults.sharedInstance.uid else
			{
				assertionFailure( "StandardDefaults returned bad uid." )
				return
			}
			self.databaseService.deleteUserRecord( forUid: uid )
			
			self.authService.deleteUser()
			{
				[weak self] errorOrNil in
				guard let strongSelf = self else
				{
					assertionFailure( "Self was nil." )
					return
				}
				guard errorOrNil == nil else
				{
					completion( errorOrNil )
					return
				}
				
				// If Firebase deleted the user successfully, let's go ahead and delete the user in Luna also.
				//
				strongSelf.lunaAPI.deleteAccount()
				{
					innerThrows in
					
					do
					{
						try innerThrows()
						strongSelf.onUserAccountDeleted()
					}
					catch
					{
						completion( error )
					}
				}
			}
		}
	}
	
	// MARK: Implementation Details
	//
	
	fileprivate func onUserAccountDeleted()
	{
		resetUserPersistenceOnDisk()
	}
	
	fileprivate func resetUserPersistenceOnDisk()
	{
		StandardDefaults.sharedInstance.uid = nil
		StandardDefaults.sharedInstance.username = nil
		StandardDefaults.sharedInstance.password = nil
	}
	
	fileprivate let lunaAPI = LunaAPI( requestor: LunaRequestor() )
	fileprivate let authService: ServiceAuthenticatable!
	fileprivate let databaseService: ServiceDBManageable!
}
