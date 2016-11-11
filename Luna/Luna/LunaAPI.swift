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
	case MissingAuthToken
	case NoUser
	
	var description: String
	{
		switch self
		{
		case .BlankUsername:
			return "The username may not be blank."
			
		case .BlankPassword:
			return "The password may not be blank."
			
		case .MissingAuthToken:
			return "The authtoken may not be missing."
			
		case .NoUser:
			return "The user may not be signed out."
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
	
	func deleteAccount( completion: @escaping(_ innterthrows: () throws -> Void ) -> Void )
	{
		guard let username = StandardDefaults.sharedInstance.username, let password = StandardDefaults.sharedInstance.password else
		{
			completion( { throw LunaAPIError.NoUser } )
			return
		}
		
		var token: AuthToken?
		let credentials = ( username, password )
		fetchAuthToken( credentials )
		{
			[weak self] inner in
			guard let strongSelf = self else
			{
				assertionFailure( "Self was nil." )
				return
			}
			
			do
			{
				token = try inner()
				strongSelf.requestor.request( endpoint: LunaEndpointAlamofire.deleteUser, credentials: nil, authToken: token )
				{
					result in
					
					switch result
					{
					// We don't care about the response, as long as it was a success.
					//
					case .success:
						completion( {} )

					case .failure( let error ):
						completion( { throw error! } )
					}
				}
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
			[weak self] result in
			guard let strongSelf = self else { return }
			
			do
			{
				let token = try strongSelf.parseLoginResponseforAuthToken( result )
				completion( { return token } )
			}
			catch
			{
				let e = error as! NetworkError
				completion( { throw e } )
			}
		}
	}
	
	fileprivate func parseLoginResponseforAuthToken(_ result: Result<Any> ) throws -> AuthToken
	{
		switch result
		{
		case .success( let data ):
			do
			{
				guard let jsonData = data as? Data else { throw NetworkError.cannotParse( "Bad data" ) }
				let json = try JSON( data: jsonData )
				let token = try json.getString( at: "auth_token", "auth_token" )
				return token
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
		
		// TODO: Currently we only need `login` and `deleteUser`, but may need other endpoints later.
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
			break
			
		case .deleteUser:
			guard let token = authToken else
			{
				completion( .failure( LunaAPIError.MissingAuthToken ) )
				return
			}
			request.setValue( "Token \( token )", forHTTPHeaderField: "Authorization" )
		
			Alamofire.request( request ).validate().response()
			{
				response in
				if let result = response.response, response.response?.statusCode == Constants.NetworkCodes.LunaDeleteAccountSuccess
				{
					completion( .success( result ) )
				}
				else
				{
					completion( .failure( NetworkError.invalid( response.error?.localizedDescription ) ) )
				}
			}
			
		default:
			assertionFailure( "Called Luna endpoint that isn't yet implemented!" )
		}
	}
}
