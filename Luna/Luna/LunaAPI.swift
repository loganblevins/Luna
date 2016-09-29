//
//  LunaAPI.swift
//  Luna
//
//  Created by Logan Blevins on 9/26/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation

final class LunaAPI<T: Endpoint, Requestor>
{
	// MARK: Public API
	//
	
	static func login( username: String, password: String ) throws
	{
		request( endpoint: .Login )
		{
			result in
			
			// TODO: Handle response
			//
		}
	}
	
	static func logout() throws
	{
		request( endpoint: .Logout )
		{
			result in
			
			// TODO: Handle response
			//
		}
	}
	
	static func me() throws
	{
		request( endpoint: .Me )
		{
			result in
			
			// TODO: Handle response
			//
		}
	}
	
	// MARK: Implementation Details
	//
	
	fileprivate func validLogin( response: AnyObject  ) -> Bool
	{
		// TODO: Parse response.
		//
		
		
		
		return false
	}
}

extension LunaAPI
{
	static func request( endpoint: LunaEndpointAlamofire, completion: ( Result<AnyObject> ) -> Void )
	{
		// FIXME: Fill in later
		//
		completion( Result.Failure( NetworkError.Invalid( nil ) ) )
	}
}
