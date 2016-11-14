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
    
    func getUserData( completion: @escaping(_ error: Error?) -> Void )
    {
        DispatchQueue.global( qos: .userInitiated ).async
        {
            self.createUserViewModel()
            {
                [weak self] errorOrNil, userViewModelOrNil in
                
                guard self != nil else
                {
                    assertionFailure( "Self was nil." )
                    return
                }
                guard errorOrNil == nil else
                {
                    completion( errorOrNil )
                    return
                }
                guard userViewModelOrNil == nil else
                {
                    self?.userViewModel = userViewModelOrNil
                    completion( errorOrNil )
                    return
                }
            }
		}

    }
    
    fileprivate func createUserViewModel( completion: @escaping(_ error: Error?, _ userViewModel: UserViewModel? ) -> Void )
    {
        guard let uid = StandardDefaults.sharedInstance.uid else
        {
            assertionFailure( "StandardDefaults returned bad uid." )
            return
        }
		
		databaseService.getLastPeriodDate( forUid: uid )
		{
			[weak self] errorOrNil, dateOrNil in
			guard let strongSelf = self else { return }
			guard errorOrNil == nil else { return }
			guard let strongDate = dateOrNil else { return }
			
			let beginDate = strongSelf.convertDate( date: strongDate )
			guard let endDate = Calendar.current.date( byAdding: .day, value: 14, to: beginDate ) else { return }
			
			let photoFetcher = PhotoFetcher()
			photoFetcher.fetchAssets( fromDate: beginDate, to: endDate )
		}
        
        self.databaseService.retrieveUserRecord( forUid: uid )
        {
            errorOrNil, userOrNil in
            
            if (userOrNil != nil)
            {
                let user = self.createUserData(uKey: uid, user: userOrNil!)
                
                let userViewModel = UserViewModel( user: user )
                
                completion ( nil, userViewModel )
            }
            else
            {
                completion ( errorOrNil, nil )
            }
        }
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
    
    fileprivate func createUserData( uKey: String, user: Dictionary<String, AnyObject>) -> User
    {
        let uid = uKey
        var birthCrtl = ""
        var cycleDate: Date = NSDate() as Date
        var len = 0
        var status = ""
        var disorder = ""
        
        if let bc = user[Constants.FirebaseStrings.DictionaryUserBirthControl] as? String
        {
            birthCrtl = bc
        }
        
        if let cd = user[Constants.FirebaseStrings.DictionaryUserCycleDate] as? String
        {
            cycleDate = convertDate(date: cd)
        }
        
        if let l = user[Constants.FirebaseStrings.DictionaryUserMenstrualLen] as? Int
        {
            len = l
        }
        
        if let s = user[Constants.FirebaseStrings.DictionaryUserRelationshipStatus] as? String
        {
            status = s
        }
        
        if let d = user[Constants.FirebaseStrings.DictionaryUserDisorder] as? String
        {
            disorder = d
        }
        
        let userData: UserData = UserData(uid: uid, birthControl: birthCrtl, lastCycle: cycleDate, cycleLength: len, relationshipStatus: status, disorder: disorder)
        
        return User(userData: userData)
    }
    
    fileprivate func convertDate( date: String ) -> Date
    {
        let time = (date as NSString).doubleValue
        
        return Date( timeIntervalSince1970: time )
    }

    var userViewModel: UserViewModel?
    
	fileprivate let lunaAPI = LunaAPI( requestor: LunaRequestor() )
	fileprivate let authService: ServiceAuthenticatable!
	fileprivate let databaseService: ServiceDBManageable!
}
