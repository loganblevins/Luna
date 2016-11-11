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
    
    func setUser()
    {
        setUserViewModel()
        {
            result in
                
            self.userViewModel = result
                
        }
    }
	
	func logout() throws
	{
		try authService.signOutUser()
	}
    
    func getUserData( completion: @escaping(_ user: User? ) -> Void )
    {
        let uid = getUID()
        
        databaseService.getUserRecord(uid: uid)
        {
            result in
            
            let user = self.createUser(uKey: uid, user: result!)
            
            completion ( user )
            
        }
    }
    
    func setUserViewModel( completion: @escaping( _ userVM: UserViewModel ) -> Void )
    {
        
        getUserData()
        {
            result in
            
            let userViewModel: UserViewModel = UserViewModel(user: result!)
            
            completion( userViewModel )
        }
    }
    
    func createUser( uKey: String, user: Dictionary<String, AnyObject>) -> User
    {
        let uid = uKey
        
        let birthCrtl = user[Constants.FirebaseStrings.DictionaryUserBirthControl] as? String
        
        let cycleDate = user[Constants.FirebaseStrings.DictionaryUserCycleDate] as? String
        let cycle = convertDate(date: cycleDate!)
        
        let len = user[Constants.FirebaseStrings.DictionaryUserMenstrualLen] as? Int
        
        let status = user[Constants.FirebaseStrings.DictionaryUserRelationshipStatus] as? String
        
        let disorder = user[Constants.FirebaseStrings.DictionaryUserDisorder] as? String

        
        let userData: UserData = UserData(uid: uid, birthControl: birthCrtl!, lastCycle: cycle, cycleLength: len!, relationshipStatus: status!, disorder: disorder!)
        
        return User(userData: userData)
    }
    
    fileprivate func convertDate( date: String ) -> Date
    {
        let time = (date as NSString).doubleValue
        
        return Date( timeIntervalSince1970: time )
    }
    
    fileprivate func getUID() -> String
    {
        return databaseService.getCurrentUser().uid
    }
	
	
    var userViewModel: UserViewModel?
    
	fileprivate let authService: ServiceAuthenticatable!
	fileprivate let databaseService: ServiceDBManageable!
    
   
}
