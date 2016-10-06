//
//  LunaTestsHelper.swift
//  Luna
//
//  Created by Logan Blevins on 10/5/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

extension LunaAPITests
{
	class FakeRequestor: Requestor
	{
		var response: Result<Any>?

		static func request<T: Endpoint>( endpoint: T, credentials: Credentials?, completion: @escaping( _ result: Result<Any> ) -> Void )
		{
			// TODO: Implement handling of fake response.
			//
			completion( result: response )
			
			
		}
		
	}
	
	struct JSON
	{
		static func fetchLoginJSON() -> Any?
		{
			guard let jsonString = LunaAPITests.stringFromFile( path: "FakeLoginResponse" ) else { return nil }
			// TODO: Manipulate JSON values/structure
			//
		}
		
	}
	
	static fileprivate func stringFromFile( path: String, type: String = "json" ) -> String?
	{
		guard let filePath = NSBundle( forClass: self ).pathForResource( path, ofType: type ) else { return nil }
		let string = try? String( contentsOfFile: filePath )
		return string
	}
	

}




