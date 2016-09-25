//
//  UserViewModel.swift
//  Luna
//
//  Created by Erika Wilcox on 9/23/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation

class UserViewModel {
    
    private var userService: UserService
    private var user: User
    
    
    
    var userID: String
    {
        return user.userID
    }
    
    var userHeight: Int
    {
        return user.height
    }
    
    var userWeight: Int
    {
        return user.weight
    }
    
    var userAge: Int
    {
        return calculateAge( birthday: (user.birthday) )
    }
    
    var userBirthCtrl: String
    {
        return user.birthCtrl
    }
    
    var userCycleLen: Int
    {
        return user.cycleLen
    }
    
    var userPeriodLen: Int
    {
        return user.periodLen
    }
    
    
    init( user: User )
    {
        self.user = user
        self.userService = UserService()
    }
    
    func calculateAge ( birthday: Date ) -> Int
    {
        let ageComps = NSCalendar.current.dateComponents([.year], from: birthday, to: NSDate() as Date)
        
        let age = ageComps.year!
        
        return age
    }
    
    func loginUser( id: String, password: String )
    {
        //self.userService.loginUser( userid: id, userpassword: password ) 
       
    }
    
    
}

