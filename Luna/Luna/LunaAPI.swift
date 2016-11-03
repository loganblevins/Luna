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

enum LunaAPIError: Error, CustomStringConvertible
{
	case BlankUsername
	case BlankPassword
	
	var description: String
	{
		switch self
		{
		case .BlankUsername:
			return "The username may not be blank."
			
		case .BlankPassword:
			return "The password may not be blank."
		}
	}
	
}

class LunaAPI
{
	// MARK: Public API
	//
	
	init( requestor: Requestor )
	{
		self.requestor = requestor
	}
	
	func login(_ credentials: Credentials, completion: @escaping(_ innerThrows: () throws -> FirebaseToken ) -> Void )
	{
		if credentials.username.isEmpty
		{
			completion( { throw LunaAPIError.BlankUsername } )
			return
		}
		if credentials.password.isEmpty
		{
			completion( { throw LunaAPIError.BlankPassword } )
			return
		}
		
		fetchToken( credentials )
		{
			inner in
			
			do
			{
				let token = try inner()
				completion( { return token } )
			}
			catch
			{
				let e = error as! NetworkError
				completion( { throw e } )
			}
		}
	}
	
	// MARK: Implementation Details
	//

	fileprivate func fetchToken(_ credentials: Credentials, completion: @escaping(_ innerThrows: () throws -> FirebaseToken ) -> Void )
	{
		requestor.request( endpoint: LunaEndpointAlamofire.login, credentials: credentials )
		{
			[weak self] result in
			guard let strongSelf = self else { return }
			
			do
			{
				let token = try strongSelf.parseLoginResponse( result )
				completion( { return token } )
			}
			catch
			{
				let e = error as! NetworkError
				completion( { throw e } )
			}
		}
	}
	
	fileprivate func parseLoginResponse(_ result: Result<Any> ) throws -> FirebaseToken
	{
		switch result
		{
		case .success( let data ):
			do
			{
				guard let jsonData = data as? Data else { throw NetworkError.cannotParse( "Bad data" ) }
				let json = try JSON( data: jsonData )
				let token = try json.getString( at: "firebase_token", "firebasetoken" )
				print( "Token: \( token )" )
				return token
			}
			catch
			{
				throw NetworkError.cannotParse( "Unable to get firebase auth_token." )
			}
			
		case .failure( let error ):
			throw error ?? NetworkError.invalid( "Unknown NetworkError" )
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
		default:
			assertionFailure( "Called Luna endpoint that isn't yet implemented!" )
		}
		
		Alamofire.request( request ).validate().responseJSON()
		{
			response in
			if let data = response.data, response.result.isSuccess
			{
				completion( .success( data ) )
			}
			else
			{
				completion( .failure( NetworkError.invalid( response.result.error?.localizedDescription ) ) )
			}
		}
	}
}
