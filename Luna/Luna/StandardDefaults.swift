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
	var initialInstall: Bool { get set }
    var birthCtrl: String? { get set }
    var lastCycle: Date? { get set }
    var cycleLen: Int? { get set }
    var relationship: String? { get set }
    var disorder: String? { get set }
    var lastPeriodUid: String? { get set }
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
	
	var initialInstall: Bool
	{
		get
		{
			return getValue( initialInstallKey ) ?? true
		}
		set
		{
			standardDefaults.set( newValue, forKey: initialInstallKey )
		}
	}
    
    var birthCtrl: String?
    {
        get
        {
            return getValue( userBirthCtrlKey )
        }
        set
        {
            print( "Persisting birth control: \( newValue )" )
            standardDefaults.set( newValue, forKey: userBirthCtrlKey )
        }
    }
    
    var lastCycle: Date?
    {
        get
        {
            return getValue( lastCycleKey )
        }
        set
        {
            print( "Persisting last cycle date: \( newValue )" )
            standardDefaults.set( newValue, forKey: lastCycleKey )
        }
    }
    
    var cycleLen: Int?
    {
        get
        {
            return getValue( cycleLenKey )
        }
        set
        {
            print( "Persisting last cycle date: \( newValue )" )
            standardDefaults.set( newValue, forKey: cycleLenKey )
        }
    }
    
    var relationship: String?
    {
        get
        {
            return getValue( relationshipKey )
        }
        set
        {
            print( "Persisting relationship: \( newValue )" )
            standardDefaults.set( newValue, forKey: relationshipKey )
        }
    }
    
    var disorder: String?
    {
        get
        {
            return getValue( disorderKey )
        }
        set
        {
            print( "Persisting disorder: \( newValue )" )
            standardDefaults.set( newValue, forKey: disorderKey )
        }
    }
    
    var lastPeriodUid: String?
    {
        get
        {
            return getValue( lastPeriodUidKey )
        }
        set
        {
            print( "Persisting disorder: \( newValue )" )
            standardDefaults.set( newValue, forKey: lastPeriodUidKey )
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
	fileprivate let initialInstallKey = "initialInstallKey"
	fileprivate let standardDefaults = UserDefaults.standard
    fileprivate let userBirthCtrlKey = "birthcontrolKey"
    fileprivate let lastCycleKey = "lastCycleKey"
    fileprivate let relationshipKey = "relationshipKey"
    fileprivate let disorderKey = "disorderKey"
    fileprivate let cycleLenKey = "cycleLenKey"
    fileprivate let lastPeriodUidKey = "lastPeriodKey"
	
	fileprivate func getValue< T >( _ key: String ) -> T?
	{
		guard let objectValue = standardDefaults.object( forKey: key ) else
		{
			return nil
		}
		
		return objectValue as? T
	}
}
