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

enum Result<T>
{
	case Success( T )
	case Failure( Error? )
}

enum NetworkError: Error, CustomStringConvertible
{
	case Invalid( String? )
	case CannotParse( String? )
	
	var description: String
	{
		switch self
		{
		case .Invalid( let reason ):
			return "Unable to make request: \( reason ?? "Unknown" )"
		case .CannotParse( let reason ):
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
	
	case Me
	case Login
	case Logout
	case ChangeUsername
	case ChangePassword
	case Activate
	case Register
	case PasswordReset
	case PasswordResetConfirm
	
	var path: String
	{
		switch self
		{
		case .Me:
			return "auth/me/"
		case .Login:
			return "auth/login/"
		case .Logout:
			return "auth/logout/"
		case .ChangeUsername:
			return "auth/username/"
		case .ChangePassword:
			return "auth/password/"
		case .Activate:
			return "auth/activate/"
		case .Register:
			return "auth/register"
		case .PasswordReset:
			return "auth/password/reset/"
		case .PasswordResetConfirm:
			return "auth/password/reset/confirm/"
		}
	}

	var method: Method
	{
		switch self
		{
		case .Me:
			return .get
		default:
			return .post
		}
	}
}

protocol Requestor
{
	func request<T: Endpoint>( endpoint: T, completion: ( _ result: Result<AnyObject> ) -> Void )
}
