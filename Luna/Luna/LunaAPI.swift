//
//  LunaAPI.swift
//  Luna
//
//  Created by Logan Blevins on 9/26/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Alamofire
import Freddy

final class LunaAPI: Requestor
{
	// MARK: Public API
	//
	
	static func login( _ credentials: Credentials ) throws
	{
		request( endpoint: LunaEndpointAlamofire.login, credentials: credentials )
		{
			response in
			
			// TODO: Handle response
			//
			
		}
	}
	
	static func request<T: Endpoint>( endpoint: T, credentials: Credentials, completion: @escaping( Result<Any> ) -> Void )
	{
		let lunaEndpoint = endpoint as! LunaEndpointAlamofire
		let urlString = Constants.LunaStrings.BaseURL.appending( lunaEndpoint.path )
		let httpBody = [Constants.LunaStrings.UsernameKey: JSON( credentials.username ),
		                Constants.LunaStrings.PasswordKey: JSON( credentials.password )]
		let json = JSON( httpBody )
		let jsonData = try! json.serialize()
		
		var request = try! URLRequest( url: urlString, method: lunaEndpoint.method )
		request.httpBody = jsonData
		request.setValue( "application/json", forHTTPHeaderField: "Content-Type" )
		
		Alamofire.request( request ).validate().responseJSON()
		{
			response in
			if let value = response.result.value, response.result.isSuccess
			{
				completion( .success( value ) )
			}
			else
			{
				completion( .failure( NetworkError.invalid( response.result.error?.localizedDescription ) ) )
			}
		}
	}
	
	// MARK: Implementation Details
	//
	
	fileprivate func validLogin( _ response: JSON ) -> Bool
	{
		// TODO: Parse response.
		//
		
		
		
		return false
	}
}



//    func loginTokenRequest( userid: String, username: String,  userpassword: String, completion: ((_ result:Bool?) -> Void)!)    {
//
//        let uid = userid
//        let user = username
//        let password = userpassword
//
//
//        var request = URLRequest( url: URL.init( string: "http://luna-track.com/api/v1/auth/login/" )! )
//        request.httpMethod = "POST"
//
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let values = [ "username" : user, "password" : password ]
//
//        request.httpBody = try! JSONSerialization.data(withJSONObject: values, options: [])
//
//        Alamofire.request(request)
//            .responseJSON{ response in
//                debugPrint(response)
//
//                switch response.result {
//                case .failure(let error):
//                    print(error)
//
//                    if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
//                        print(responseString)
//                    }
//                    completion(false)
//
//                case .success(let responseObject):
//                    print(responseObject)
//                    self.postDataToFirebase(postid: uid, postType: "userToken", postData: responseObject as AnyObject)
//
//                    completion(true)
//                }
//
//        }
//
//    }

//    func postDataToFirebase ( postid: String, postType: String, postData: AnyObject )
//    {
//        FirebaseService().refUsers.child(postid).child(postType).setValue(postData)
//    }
//
//    func postUserToFirbase ( user: User )
//    {
//
//    }
//
//    func anonymousUser( anonymousId: String )
//    {
//        FirebaseService().refUsers.child(anonymousId).setValue(["anonymous": "yes"])
//    }

