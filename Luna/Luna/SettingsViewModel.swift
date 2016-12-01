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
    
    
    func createUserViewModel( completion: ( _ userViewModel: UserViewModel? ) -> Void )
    {
        
        let user = createUserDataObject()
        if user != nil
        {
            let userViewModel = UserViewModel ( user: user! )
            completion ( userViewModel )
        }
        else
        {
            completion ( nil )
        }

    }
    
    func setUserViewModel( userVM: UserViewModel )
    {
        userViewModel = userVM
    }
    
    fileprivate func createUserDataObject() -> User?
    {
        guard let uid = StandardDefaults.sharedInstance.uid else
        {
            assertionFailure( "StandardDefaults returned bad uid." )
            return nil
        }
        
        guard let uBirthCtrl = StandardDefaults.sharedInstance.birthCtrl else
        {
            assertionFailure( "StandardDefaults returned bad uid." )
            return nil
        }
        
        guard let uLastCycle = StandardDefaults.sharedInstance.lastCycle else
        {
            assertionFailure( "StandardDefaults returned bad uid." )
            return nil
        }
        
        guard let uCycleLen = StandardDefaults.sharedInstance.cycleLen else
        {
            assertionFailure( "StandardDefaults returned bad uid." )
            return nil
        }
        
        guard let uRelationship = StandardDefaults.sharedInstance.relationship else
        {
            assertionFailure( "StandardDefaults returned bad uid." )
            return nil
        }
        
        guard let uDisorder = StandardDefaults.sharedInstance.disorder else
        {
            assertionFailure( "StandardDefaults returned bad uid." )
            return nil
        }
        
        let userData: UserData = UserData(uid: uid, birthControl: uBirthCtrl, lastCycle: uLastCycle, cycleLength: uCycleLen, relationshipStatus: uRelationship, disorder: uDisorder)
        
        return User( userData: userData )
    
    }
    
    
    fileprivate func convertDate( date: String ) -> Date
    {
        let time = (date as NSString).doubleValue
        
        return Date( timeIntervalSince1970: time )
    }
    


	// Complex method completing 3 procedures in this order: Delete from ServiceDB -> Delete from ServiceAuthenticatable -> Delete from Luna
	//
	// If any one of the procedures fails, the entire chain stops.
	//
	// If the first procedure fails, everything else stops too.
	//
	func deleteAccountAsync( completion: @escaping(_ error: Error? ) -> Void )
	{
		DispatchQueue.global( qos: .userInitiated ).async
		{
			self.deleteUserFromServiceDBManageable()
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
				
				strongSelf.deleteUserFromServiceAuthenticatable()
				{
					errorOrNil in
					guard errorOrNil == nil else
					{
						completion( errorOrNil )
						return
					}
					strongSelf.deleteUserFromLuna()
					{
						errorOrNil in
						completion( errorOrNil )
					}
				}
			}
		}
	}
	
	// MARK: Implementation Details
	//
	
	fileprivate func deleteUserFromServiceDBManageable( completion: @escaping(_ error: Error? ) -> Void )
	{
		// Delete user in Firebase.
		//
		guard let uid = StandardDefaults.sharedInstance.uid else
		{
			assertionFailure( "StandardDefaults returned bad uid." )
			return
		}
		
		// This method MUST be called BEFORE the Firebase user is deleted!
		// If the order is reversed, the DB will not have access to read/write.
		//
		
		// Sets up a listener to detect errors on account deletion.
		//
		// Block is invoked a single time on detection of `childRemoved` change.
		//
		self.databaseService.waitForUserDeletion( forUid: uid )
		{
			errorOrNil in
			completion( errorOrNil )
		}
		self.databaseService.deleteUserRecord( forUid: uid )
	}

	fileprivate func deleteUserFromServiceAuthenticatable( completion: @escaping(_ error: Error? ) -> Void )
	{
		self.authService.deleteUser()
		{
			errorOrNil in
			completion( errorOrNil )
		}
	}

	fileprivate func deleteUserFromLuna( completion: @escaping(_ error: Error? ) -> Void )
	{
		// If Firebase deleted the user successfully, let's go ahead and delete the user in Luna also.
		//
		self.lunaAPI.deleteAccount()
		{
			[weak self] innerThrows in
			guard let strongSelf = self else
			{
				assertionFailure( "Self was nil." )
				return
			}
			
			do
			{
				try innerThrows()
				strongSelf.onUserAccountDeleted()
				completion( nil )
			}
			catch
			{
				completion( error )
			}
		}
	}
	
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
    

    
    

    var userViewModel: UserViewModel?
    
	fileprivate let lunaAPI = LunaAPI( requestor: LunaRequestor() )
	fileprivate let authService: ServiceAuthenticatable!
	fileprivate let databaseService: ServiceDBManageable!
}
