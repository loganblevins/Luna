//
//  LoginViewModel.swift
//  Luna
//
//  Created by Erika Wilcox on 9/24/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation
import Firebase

//Everything Anonymous will be removed
class LoginViewModel
{
    
    var userService: UserService
    var anonymousID: String
    
    init()
    {
        userService = UserService()
        anonymousID = ""
    }
    
    func anonymousAuth ()
    {
        userService.firebaseAuthAnonymous(){
            (res) in
            
            self.anonymousID = res!
        }
    }
    
    func loginUser( username: String, userpassword: String, completion: ((_ result:Bool?) -> Void)!)
    {
        userService.loginUser(userid: anonymousID, username: username, userpassword: userpassword) { (res) in
            if (res)!
            {
                print ("yes")
                completion(true)
            }
            else
            {
                print ("no")
                completion(false)
            }
        }
    }
    
    
}
