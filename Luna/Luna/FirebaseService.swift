//
//  FirebaseService.swift
//  Luna
//
//  Created by Erika Wilcox on 9/23/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Firebase

protocol ServiceAuthenticatable
{
	func signInUser( withToken token: String, completion: @escaping(_ error: Error? ) -> Void )
	func signOutUser() throws
	
	var currentUser: Any? { get }
}

protocol ServiceStorable
{
	// TODO: Fill in generic storage needs.
	//
}

protocol ServiceDBManageable
{
	// TODO: Fill in generic database needs.
	//
}

struct FirebaseAuthenticationService: ServiceAuthenticatable
{
	static func AuthChangeListener( completion: @escaping(_ user: FIRUser? ) -> Void ) -> FIRAuthStateDidChangeListenerHandle!
	{
		let handle = FIRAuth.auth()?.addStateDidChangeListener()
		{
			_, user in
			
			print( "Firebase auth state did change." )
			completion( user )
		}
		return handle!
	}
	
	static func RemoveAuthChangeListener(_ handle: FIRAuthStateDidChangeListenerHandle! )
	{
		FIRAuth.auth()?.removeStateDidChangeListener( handle )
	}
	
	func signInUser( withToken token: FirebaseToken, completion: @escaping(_ error: Error? ) -> Void)
	{
		print( "Attempting to sign in user." )
		
		FIRAuth.auth()?.signIn( withCustomToken: token )
		{
			user, error in
			
			completion( error )
		}
	}
	
	func signOutUser() throws
	{
		print( "Attempting to sign out user." )
		try FIRAuth.auth()?.signOut()
	}
	
	var currentUser: Any?
	{
		return nil
	}
}

struct FirebaseStorageService: ServiceStorable
{
	
}

struct FirebaseDBService: ServiceDBManageable
{
//	fileprivate let FirebaseDB = FIRDatabase.database().reference()
	
//	fileprivate var Users = FirebaseDB.child( Constants.FirebaseStrings.ChildUsers )
//	fileprivate var Entry = FirebaseDB.child( Constants.FirebaseStrings.ChildEntry )
//	fileprivate var DailyEntries = FirebaseDB.child( Constants.FirebaseStrings.ChildDailyEntries )
}
