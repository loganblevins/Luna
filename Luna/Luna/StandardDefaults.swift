//
//  StandardDefaults.swift
//  Luna
//
//  Created by Logan Blevins on 9/23/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation

protocol StandardDefaultsProtocol: class
{
	// Insert any members needed stored to disk.
	// Use as getters and setters. If we write tests involving StandardDefaults, we can override behavior with this interface.
	//
	
	var uid: String? { get set }
	var username: String? { get set }
	var password: String? { get set }
}

class StandardDefaults: StandardDefaultsProtocol
{
	// MARK: Public API
	//
	
	// Everytime a member is updated it will automatically get stored to disk.
	//
	
	var uid: String?
	{
		get
		{
			return getValue( uidKey )
		}
		set
		{
			print( "Persisting uid: \( newValue )" )
			standardDefaults.set( newValue, forKey: uidKey )
		}
	}
	
	var username: String?
	{
		get
		{
			return getValue( usernameKey )
		}
		set
		{
			print( "Persisting username: \( newValue )" )
			standardDefaults.set( newValue, forKey: usernameKey )
		}
	}
	
	var password: String?
	{
		get
		{
			return getValue( passwordKey )
		}
		set
		{
			print( "Persisting password: \( newValue )" )
			standardDefaults.set( newValue, forKey: passwordKey )
		}
	}
	
	// Insert any members needing stored to disk.
	// Database files?
	//

	// MARK: Singleton Implementation
	//
	
	static let sharedInstance = StandardDefaults()
	fileprivate init() {}
	
	// MARK: Implementation Details
	//
	
	// Insert keys for objects here
	//
	
	fileprivate let uidKey = "uidKey"
	fileprivate let usernameKey = "usernameKey"
	fileprivate let passwordKey = "passwordKey"
	fileprivate let standardDefaults = UserDefaults.standard
	
	fileprivate func getValue< T >( _ key: String ) -> T?
	{
		guard let objectValue = standardDefaults.object( forKey: key ) else
		{
			return nil
		}
		
		return objectValue as? T
	}
}
