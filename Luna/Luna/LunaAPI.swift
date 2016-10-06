//
//  LunaAPI.swift
//  Luna
//
//  Created by Logan Blevins on 9/26/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Alamofire
import Freddy

class LunaAPI
{
	// MARK: Public API
	//
	
	init( requestor: Requestor )
	{
		self.requestor = requestor
	}
	
	typealias FirebaseToken = String
	
	static func login( _ credentials: Credentials ) throws -> FirebaseToken?
	{
		firebaseAuthToken( credentials: credentials )
		{
			
		}
	}
	
	// MARK: Implementation Details
	//
	
	static fileprivate func fetchFirebaseToken( credentials: Credentials, completion: ( Result<FirebaseToken> ) -> Void )
	{
		// TODO: Parse response.
		//
		request( endpoint: LunaEndpointAlamofire.login, credentials: credentials )
		{
			result in
			
			switch result
			{
			case .success( let data ):
				// TODO: Save credentials to disk or something.
				//
				
				guard let token = firebaseAuthToken( credentials: credentials ) else
				{
					
				}
				
			case .failure( let error ):
				
			}
		}

		
		return ""
	}
	
	fileprivate let requestor: Requestor

}

extension Requestor where Self: LunaAPI
{
	static func request<T: Endpoint>( endpoint: T, credentials: Credentials?, completion: @escaping( Result<Any> ) -> Void )
	{
		let lunaEndpoint = endpoint as! LunaEndpointAlamofire
		let urlString = Constants.LunaStrings.BaseURL.appending( lunaEndpoint.path )
		var request = try! URLRequest( url: urlString, method: lunaEndpoint.method )
		
		// TODO: Currently we only need `login`, but may need other endpoints later.
		// This method is gerneric so the endpoint matters here.
		// e.g. `login` is a POST request requiring credentials sent in a JSON data format
		// of the request body. Other endpoints are different. Let's crash on anything other
		// than `login`, since it shouldn't be implemented yet.
		//
		switch lunaEndpoint
		{
		case .login:
			let httpBody = [Constants.LunaStrings.UsernameKey: JSON( credentials!.username ),
			                Constants.LunaStrings.PasswordKey: JSON( credentials!.password )]
			let json = JSON( httpBody )
			let jsonData = try! json.serialize()
			request.httpBody = jsonData
			request.setValue( "application/json", forHTTPHeaderField: "Content-Type" )
		default:
			assertionFailure( "Called Luna endpoint that isn't yet implemented!" )
		}
		
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
	
}




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

