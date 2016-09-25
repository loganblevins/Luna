//
//  OnBoardViewModel.swift
//  Luna
//
//  Created by Erika Wilcox on 9/24/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation
import Firebase



class OnBoardViewModel
{
    var userService: UserService
    var anonymousID: String
    var dataTypes: Dictionary<Int, String>
    
    init( uid: String )
    {
        userService = UserService()
        anonymousID = uid
        dataTypes = [0: "Birthday", 1:"Height", 2: "Weight", 3:"CycleLength", 4: "PeriodLength", 5:"LastPeriod", 6:"BirthControl"]
        

    }
    
    func calculateAge ( birthday: Date ) -> Bool
    {
        let ageComps = NSCalendar.current.dateComponents([.year], from: birthday, to: NSDate() as Date)
        
        let age = ageComps.year!
        
        if ( age > 17 )
        {
            return true
        }
        else
        {
            return false
        }
        
    }
    
    func getDataType ( key: Int ) -> String
    {
        return dataTypes[key]!
    }
    
    func saveUserInfo ( postType: String, postData: String )
    {
        userService.postData(uid: anonymousID, postType: postType, postData: postData)
    }

}
