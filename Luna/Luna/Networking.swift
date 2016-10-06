//
//  Networking.swift
//  Luna
//
//  Created by Logan Blevins on 9/16/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Alamofire

// MARK: Public API
//

typealias Credentials = ( username: String, password: String )

enum Result<T>
{
	case success( T )
	case failure( Error? )
}

enum NetworkError: Error, CustomStringConvertible
{
	case invalid( String? )
	case cannotParse( String? )
	
	var description: String
	{
		switch self
		{
		case .invalid( let reason ):
			return "Unable to make request: \( reason ?? "Unknown" )"
		case .cannotParse( let reason ):
			return "Unable to parse response: \( reason ?? "Unknown" )"
		}
	}
}

// TODO: Do I need to include a parameters member??
//
protocol Endpoint
{
	associatedtype Method
	var path: String { get }
	var method: Method { get }
}

enum LunaEndpointAlamofire: Endpoint
{
	typealias Method = Alamofire.HTTPMethod
	
	case login
	case me
	case logout
	case changeUsername
	case changePassword
	case activate
	case register
	case passwordReset
	case passwordResetConfirm
	
	var path: String
	{
		switch self
		{
		case .login:
			return Constants.LunaStrings.LoginEndpoint
		case .me:
			return Constants.LunaStrings.MeEndpoint
		case .logout:
			return Constants.LunaStrings.LogoutEndpoint
		case .changeUsername:
			return Constants.LunaStrings.ChangeUsernameEndpoint
		case .changePassword:
			return Constants.LunaStrings.ChangePasswordEndpoint
		case .activate:
			return Constants.LunaStrings.ActivateEndpoint
		case .register:
			return Constants.LunaStrings.RegisterEnpoint
		case .passwordReset:
			return Constants.LunaStrings.PasswordResetEndpoint
		case .passwordResetConfirm:
			return Constants.LunaStrings.PasswordResetConfirmEndpoint
		}
	}

	var method: Method
	{
		switch self
		{
		case .me:
			return .get
		default:
			return .post
		}
	}
}

protocol Requestor
{
	static func request<T: Endpoint>( endpoint: T, credentials: Credentials?, completion: @escaping( _ result: Result<Any> ) -> Void )
}
