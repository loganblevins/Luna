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
typealias AuthToken = String

enum LunaAPIError: Error, CustomStringConvertible
{
	case BlankUsername
	case BlankPassword
	case MissingToken
	
	var description: String
	{
		switch self
		{
		case .BlankUsername:
			return "The username may not be blank."
			
		case .BlankPassword:
			return "The password may not be blank."
			
		case .MissingToken:
			return "The auth token may not be missing."
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
		
		fetchFirebaseToken( credentials )
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
	
	func deleteAccount( forToken token: FirebaseToken, completion: @escaping(_ error: Error? ) -> Void )
	{
		
	}
	
	// MARK: Implementation Details
	//

	fileprivate func fetchFirebaseToken(_ credentials: Credentials, completion: @escaping(_ innerThrows: () throws -> FirebaseToken ) -> Void )
	{
		requestor.request( endpoint: LunaEndpointAlamofire.login, credentials: credentials, authToken: nil )
		{
			[weak self] result in
			guard let strongSelf = self else { return }
			
			do
			{
				let token = try strongSelf.parseLoginResponseForFirebaseToken( result )
				completion( { return token } )
			}
			catch
			{
				let e = error as! NetworkError
				completion( { throw e } )
			}
		}
	}
	
	fileprivate func parseLoginResponseForFirebaseToken(_ result: Result<Any> ) throws -> FirebaseToken
	{
		switch result
		{
		case .success( let data ):
			do
			{
				guard let jsonData = data as? Data else { throw NetworkError.cannotParse( "Bad data" ) }
				let json = try JSON( data: jsonData )
				let token = try json.getString( at: "firebase_token", "firebasetoken" )
				return token
			}
			catch
			{
				throw NetworkError.cannotParse( "Unable to get firebasetoken." )
			}
			
		case .failure( let error ):
			throw error ?? NetworkError.invalid( "Unknown NetworkError" )
		}
	}
	
	fileprivate func fetchAuthToken(_ credentials: Credentials, completion: @escaping(_ innerThrows: () throws -> AuthToken ) -> Void )
	{
		requestor.request( endpoint: LunaEndpointAlamofire.login, credentials: credentials, authToken: nil )
		{
			
		}
	}
	
	fileprivate func parseLoginResponseforAuthToken(_ result: Result<Any> ) throws -> AuthToken
	{
		switch result
		{
		case .success( let data ):
			do
			{
				
			}
			catch
			{
				throw NetworkError.cannotParse( "Unable to get authtoken.")
			}
			
		case .failure( let error ):
			throw error ?? NetworkError.invalid( "Unknown NetworkError" )
		}
	}
	
	fileprivate let requestor: Requestor!
}

struct LunaRequestor: Requestor
{
	func request<T: Endpoint>( endpoint: T, credentials: Credentials?, authToken: String?, completion: @escaping( Result<Any> ) -> Void )
	{
		let lunaEndpoint = endpoint as! LunaEndpointAlamofire
		let urlString = Constants.LunaStrings.BaseURL.appending( lunaEndpoint.path )
		var request = try! URLRequest( url: urlString, method: lunaEndpoint.method )
		
		// TODO: Currently we only need `login`, but may need other endpoints later.
		// This method is generic so the endpoint matters here.
		//
		// Let's crash on anything other than `login` or `deleteUser`, since it shouldn't be implemented yet.
		//
		switch lunaEndpoint
		{
		case .login:
			guard let username = credentials?.username else
			{
				completion( .failure( LunaAPIError.BlankUsername ) )
				return
			}
			guard let password = credentials?.password else
			{
				completion( .failure( LunaAPIError.BlankPassword ) )
				return
			}
			let postString = "\( Constants.LunaStrings.UsernameKey )=\( username )&\( Constants.LunaStrings.PasswordKey )=\( password )"
			request.httpBody = postString.data( using: .utf8 )
			
		case .deleteUser:
			guard let token = authToken else
			{
				completion( .failure( LunaAPIError.MissingToken ) )
				return
			}
			// Let's just assume that the token is convertible to data and base64 string. 
			// If it's `nil`, we have bigger problems at stake.
			//
			let tokenData = token.data( using: .utf8 )
			let base64Token = tokenData?.base64EncodedString()
			request.setValue( "Token \( base64Token )", forHTTPHeaderField: "Authorization" )
			
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
