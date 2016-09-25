
//
//  UserService.swift
//  Luna
//
//  Created by Erika Wilcox on 9/24/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation
import Alamofire
import Firebase


class UserService {
    
    var networkHelper: NetworkHelper?
    
    init()
    {
        networkHelper = NetworkHelper()
    }
    
    func loginUser( userid: String, username: String, userpassword: String, completion: ((_ result:Bool?) -> Void)!)
    {
       
        networkHelper?.loginTokenRequest(userid: userid, username: username,  userpassword: userpassword, completion: { results in
            if (results)!
            {
                print ("yes")
                completion(true)
            }
            else
            {
                print ("no")
                completion(false)
            }
        })
        
    }
    
    
    func postData ( uid: String, postType: String, postData: String )
    {
        networkHelper?.postDataToFirebase(postid: uid, postType: postType, postData: postData as AnyObject)
    }
    
    func firebaseAuthAnonymous ( completion: ((_ result:String?) -> Void)!)
    {
        FIRAuth.auth()?.signInAnonymously() { (user, error) in
            let uid = user!.uid
            self.postAnonymous(uid: uid as String)
            completion(uid)
        }
    }
    
    func postAnonymous( uid: String )
    {
        networkHelper?.anonymousUser(anonymousId: uid)
    }
    
    
}
