//
//  LunaTests.swift
//  LunaTests
//
//  Created by Logan Blevins on 9/13/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import XCTest
@testable import Luna

class LunaAPITests: XCTestCase
{
    
    let authTokenLength = 40
    let fireBaseTokenLength = 851
    
//	override func setUp()
//	{
//		super.setUp()
//		fakeRequestor = FakeRequestor()
//	}
//	
//	override func tearDown()
//	{
//		super.tearDown()
//		fakeRequestor = nil
//	}
//	
//	func testValidLogin()
//	{
//		let validCredentials = ( "someValidUsername", "someValidPassword" )
//		
//		fakeRequestor.response = Result.success( JSON.validLoginResponse() )
//		
//		let sut = LunaAPI( requestor: fakeRequestor )
//		do
//		{
//			try sut.login( validCredentials )
//			{
//				result in
//				
//				// TODO: Handle result
//			}
//		}
//		catch let error
//		{
//			// Safe to force down-cast as our `Network Error` since we're guaranteed to never encounter any other error type in this context.
//			//
//			let e = error as! NetworkError
//			print( e.description )
//			
//			// TODO: Handle error
//			//
//		}
//	}
	

	func testValidObjectCount()
	{       // expects an instance of auth token and firebase token
        let jsonDict = JSON.validLoginResponse() as! Dictionary< String, Any >
        XCTAssert( jsonDict.count == 2)
        
	}
    
    // maybe make sure the objects are "auth_token" and "firebase_token"?
    
    func testValidObjectCount2()
    {     // expects one instance of auth token
        let jsonDict = JSON.validLoginResponse() as! Dictionary< String, Any >
        let authToken = jsonDict["auth_token"] as! Dictionary< String, Any >
        let count = authToken.count
        XCTAssert( count == 1 )
        
    }
   
    func testValidObjectCount3()
    {       // expects one instance of the token for auth token
        let jsonDict = JSON.validLoginResponse() as! Dictionary< String, Any >
        let authToken = jsonDict["auth_token"] as! Dictionary< String, Any >
        let innerAuthToken = authToken["auth_token"] as! String
        let count = innerAuthToken.count
        XCTAssert( authTokenLength == count)
    }
    
    func testValidObjectCount4()
    {       // expects one instance of firebase token
        let jsonDict = JSON.validLoginResponse() as! Dictionary< String, Any >
        let firebaseToken = jsonDict["firebase_token"] as! Dictionary< String, Any >
        let count = firebaseToken.count
        XCTAssert( count == 1)
    }
    
    func testValidObjectCount5()
    {       // expects one instance of the token for firebasetoken
        let jsonDict = JSON.validLoginResponse() as! Dictionary< String, Any >
        let firebaseToken = jsonDict["firebase_token"] as! Dictionary< String, Any >
        let innerAuthToken = firebaseToken["firebasetoken"] as! String
        let count = innerAuthToken.count
        XCTAssert( fireBaseTokenLength == count)
    }
    
    //
//	func testFailureWithTODO_SOME_ERROR1Login()
//	{
//		let invalidCredentials = ( "someInvalidUsername", "someInvalidPassword" )
//
//		
//		fakeRequestor.response = Result.failure(<#T##Error?#>)
//		let sut = LunaAPI( requestor: fakeRequestor )
//
//	}
//	
//	func testFailureWithTODO_SOME_ERROR2Login()
//	{
//		let invalidCredentials = ( "someInvalidUsername", "someInvalidPassword" )
//		
//		fakeRequestor.response = Result.failure(<#T##Error?#>)
//		let sut = LunaAPI( requestor: fakeRequestor )
//
//	}
//	
//	func testFailureInvalidWithTODO_SOME_ERROR3Login()
//	{
//		let invalidCredentials = ( "someInvalidUsername", "someInvalidPassword" )
//
//		fakeRequestor.response = Result.failure( NetworkError.invalid( "TODO: SOME ERROR MESSAGE OR NIL" ))
//		let sut = LunaAPI( requestor: fakeRequestor )
//
//	}
//	
//	func testFailureCannotParseWithTODO_SOME_ERROR4Login()
//	{
//		let invalidCredentials = ( "someInvalidUsername", "someInvalidPassword" )
//
//		fakeRequestor.response = Result.failure( NetworkError.cannotParse( "TODO: SOME ERROR MESSAGE OR NIL" ) )
//		let sut = LunaAPI( requestor: fakeRequestor )
//
//	}
//	
//	fileprivate var fakeRequestor: FakeRequestor!
}
