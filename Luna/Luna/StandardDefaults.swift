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
	// Use as getters and setters.
	//
	
	var uid: String? { get set }
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
			standardDefaults.set( newValue, forKey: uidKey )
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
