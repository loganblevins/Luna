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
	override func setUp()
	{
		super.setUp()
		fakeRequestor = FakeRequestor()
	}
	
	override func tearDown()
	{
		super.tearDown()
		fakeRequestor = nil
	}
	
	func testValidLogin()
	{
		let validCredentials = ( "someValidUsername", "someValidPassword" )
		
		fakeRequestor.response = Result.success( JSON.validLoginResponse() )
		
		let sut = LunaAPI( requestor: fakeRequestor )
		do
		{
			try sut.login( validCredentials )
			{
				result in
				
				// TODO: Handle result
			}
		}
		catch let error
		{
			// Safe to force down-cast as our `Network Error` since we're guaranteed to never encounter any other error type in this context.
			//
			let e = error as! NetworkError
			print( e.description )
			
			// TODO: Handle error
			//
		}
	}
	
	func testFailureWithTODO_SOME_ERRORLogin()
	{
//		let invalidCredentials = ( "someInvalidUsername", "someInvalidPassword" )
//		
////		fakeRequestor.response = Result.failure(<#T##Error?#>)
//		let sut = LunaAPI( requestor: fakeRequestor )

	}
	
	func testFailureWithTODO_SOME_ERROR1Login()
	{
//		let invalidCredentials = ( "someInvalidUsername", "someInvalidPassword" )
//
//		
////		fakeRequestor.response = Result.failure(<#T##Error?#>)
//		let sut = LunaAPI( requestor: fakeRequestor )

	}
	
	func testFailureWithTODO_SOME_ERROR2Login()
	{
//		let invalidCredentials = ( "someInvalidUsername", "someInvalidPassword" )
//		
////		fakeRequestor.response = Result.failure(<#T##Error?#>)
//		let sut = LunaAPI( requestor: fakeRequestor )

	}
	
	func testFailureInvalidWithTODO_SOME_ERROR3Login()
	{
//		let invalidCredentials = ( "someInvalidUsername", "someInvalidPassword" )
//
//		fakeRequestor.response = Result.failure( NetworkError.invalid( "TODO: SOME ERROR MESSAGE OR NIL" ))
//		let sut = LunaAPI( requestor: fakeRequestor )

	}
	
	func testFailureCannotParseWithTODO_SOME_ERROR4Login()
	{
//		let invalidCredentials = ( "someInvalidUsername", "someInvalidPassword" )
//
//		fakeRequestor.response = Result.failure( NetworkError.cannotParse( "TODO: SOME ERROR MESSAGE OR NIL" ) )
//		let sut = LunaAPI( requestor: fakeRequestor )

	}
	
	fileprivate var fakeRequestor: FakeRequestor!
}
