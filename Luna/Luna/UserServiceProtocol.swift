//
//  UserServiceProtocol.swift
//  Luna
//
//  Created by Erika Wilcox on 9/24/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation
import Alamofire

protocol UserSerivceProtocol
{
    
    func loginTokenRequest( userid: String, username: String, userpassword: String, completion: ((_ result:Bool?) -> Void)!)

    func postDataToFirebase ( postid: String, postType: String, postData: AnyObject )
    
    func postUserToFirbase ( user: user )
    
    func anonymousUser( anonymousId: String )
    
}

struct NetworkHelper: UserSerivceProtocol
{

    func loginTokenRequest( userid: String, username: String,  userpassword: String, completion: ((_ result:Bool?) -> Void)!)    {
        
        let uid = userid
        let user = username
        let password = userpassword
        
		
        var request = URLRequest( url: URL.init( string: "http://luna-track.com/api/v1/auth/login/" )! )
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let values = [ "username" : user, "password" : password ]
        
        request.httpBody = try! JSONSerialization.data(withJSONObject: values, options: [])
        
        Alamofire.request(request)
            .responseJSON{ response in
                debugPrint(response)
                
                switch response.result {
                case .failure(let error):
                    print(error)
                    
                    if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                        print(responseString)
                    }
                    completion(false)
                    
                case .success(let responseObject):
                    print(responseObject)
                    self.postDataToFirebase(postid: uid, postType: "userToken", postData: responseObject as AnyObject)
                    
                    completion(true)
                }
                
        }
        
    }
    
    func postDataToFirebase ( postid: String, postType: String, postData: AnyObject )
    {
        FirebaseService().refUsers.child(postid).child(postType).setValue(postData)
    }
    
    func postUserToFirbase ( user: user )
    {
        
    }
    
    func anonymousUser( anonymousId: String )
    {
        FirebaseService().refUsers.child(anonymousId).setValue(["anonymous": "yes"])
    }
}
