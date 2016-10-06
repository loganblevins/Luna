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
	var requestor: FakeRequestor!
	
	func testInvalidLogin()
	{
		let sut = LunaAPI( requestor: )
	}
	

	
    override func setUp() {
        super.setUp()
		
		requestor = FakeRequestor()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
}



