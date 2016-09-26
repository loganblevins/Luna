//
//  LunaAPI.swift
//  Luna
//
//  Created by Logan Blevins on 9/26/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation

final class LunaAPI
{
	init<T: Requestor>( requestor: T )
	{
//		self.requestor = requestor
	}
	func request<T: Endpoint>( endpoint: T, completion: ( Result<AnyObject> ) -> Void )
	{
		
	}

//	private let requestor: 
}
