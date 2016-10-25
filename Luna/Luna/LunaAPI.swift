//
//  LunaAPI.swift
//  Luna
//
//  Created by Logan Blevins on 9/26/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Alamofire
import Freddy

typealias FirebaseToken = String

protocol LunaAPIProtocol: class
{
	func login( _ credentials: Credentials, completion: @escaping( FirebaseToken? ) -> Void )
}

class LunaAPI: LunaAPIProtocol
{
	// MARK: Public API
	//
	
	init( requestor: Requestor )
	{
		self.requestor = requestor
	}
	
	func login( _ credentials: Credentials, completion: @escaping( FirebaseToken? ) -> Void )
	{
		requestor.request( endpoint: LunaEndpointAlamofire.login, credentials: credentials )
		{
			[weak self] result in
			guard let strongSelf = self else { return }
			
			do
			{
				let token = try strongSelf.parseLoginResponse( result )
				completion( token )
			}
			catch
			{
				let e = error as! NetworkError
				print ( e.description )
				completion( nil )
			}
		}
	}
	
	// MARK: Implementation Details
	//
	
	
	fileprivate func parseLoginResponse(_ result: Result<Any> ) throws -> FirebaseToken
	{
		switch result
		{
		case .success( let value ):
			
			// TODO: Parse with Freddy!
			//
			
			print( value )
			return ""
			
		case .failure( let error ):
			throw error!
		}
	}
	
	fileprivate let requestor: Requestor!

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

