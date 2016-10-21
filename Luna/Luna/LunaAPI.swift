//
//  LunaAPI.swift
//  Luna
//
//  Created by Logan Blevins on 9/26/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Alamofire
import Freddy

protocol LunaAPIProtocol: class
{
	func login( _ credentials: Credentials, completion: ( _ result: Result<Any> ) -> Void ) throws
}

class LunaAPI: LunaAPIProtocol
{

	// MARK: Public API
	//
	
	typealias FirebaseToken = String
	
	init( requestor: Requestor )
	{
		self.requestor = requestor
	}
	
	func login( _ credentials: Credentials, completion: ( Result<Any> ) -> Void ) throws
	{
		fetchFirebaseToken( credentials: credentials )
		{
			result in
			
			
		}
	}
	

	
	// MARK: Implementation Details
	//
	
	fileprivate func fetchFirebaseToken( credentials: Credentials, completion: @escaping( Result<FirebaseToken> ) -> Void )
	{
		// TODO: Parse response.
		//
		requestor.request( endpoint: LunaEndpointAlamofire.login, credentials: credentials )
		{
			result in
			
			switch result
			{
			case .success( let data ):
				// TODO: Save credentials to disk or something.
				//
				
				completion( .success( data as! FirebaseToken ) )
				
			case .failure( let error ):
				let e = error as! NetworkError
				completion( .failure( e ) )
				
			}
		}

	}
	
	fileprivate func parseLoginResponse( result: Result<Any> ) -> FirebaseToken?
	{
		return nil
	}
	
	fileprivate let requestor: Requestor

}

struct LunaRequestor: Requestor
{
	func request<T: Endpoint>( endpoint: T, credentials: Credentials?, completion: @escaping( Result<Any> ) -> Void )
	{
		let lunaEndpoint = endpoint as! LunaEndpointAlamofire
		let urlString = Constants.LunaStrings.BaseURL.appending( lunaEndpoint.path )
		var request = try! URLRequest( url: urlString, method: lunaEndpoint.method )
		
		// TODO: Currently we only need `login`, but may need other endpoints later.
		// This method is generic so the endpoint matters here.
		//
		// e.g. `login` is a POST request requiring credentials sent in a JSON data format
		// of the request body. Other endpoints are different. Let's crash on anything other
		// than `login`, since it shouldn't be implemented yet.
		//
		switch lunaEndpoint
		{
		case .login:
			let postString = "\( Constants.LunaStrings.UsernameKey )=\( credentials!.username )&\( Constants.LunaStrings.PasswordKey )=\( credentials!.password )"
			request.httpBody = postString.data( using: .utf8 )
//			request.setValue( "application/json", forHTTPHeaderField: "Content-Type" )
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

