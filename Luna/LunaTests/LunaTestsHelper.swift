//
//  LunaTestsHelper.swift
//  Luna
//
//  Created by Logan Blevins on 10/5/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation
@testable import Luna

extension LunaAPITests
{
//	class FakeRequestor: Requestor
//	{
//		var response: Result<Any>?
//
//		func request<T: Endpoint>( endpoint: T, credentials: Credentials?, completion: @escaping( _ result: Result<Any> ) -> Void )
//		{
//			// TODO: Implement handling of fake response.
//			//
//			completion( response! )
//			
//			
//		}
//		
//	}
	
	struct JSON
	{
		static func validLoginResponse() -> Any?
		{
            let jsonData = LunaAPITests.fetchFakeLoginResponseJsonData()
            let json = try? JSONSerialization.jsonObject( with: jsonData!, options: .allowFragments )
            return json
		}
        

        // missing authentication token
        static func invalidNoAuthenticationToken() -> Any?
        {
            let jsonData = LunaAPITests.fetchFakeLoginResponseJsonData()!
            let json = try? JSONSerialization.jsonObject( with: jsonData, options: .allowFragments )
            return json
        }
        
        
	}
	
    static func fetchFakeLoginResponseJsonData() -> Data?
    {
        guard let jsonString = LunaAPITests.stringFromFile( path: "FakeLoginResponse" ) else { return nil }
        let jsonData = jsonString.data( using: .utf8 )
        return jsonData
    }
    
	static fileprivate func stringFromFile( path: String, type: String = "json" ) -> String?
	{
		guard let filePath = Bundle( for: self ).path( forResource: path, ofType: type ) else { return nil }
		let string = try? String( contentsOfFile: filePath )
		return string
	}
}
