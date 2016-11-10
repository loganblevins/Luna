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
	func signInUser( withToken token: String, completion: @escaping(_ userID: String?, _ error: Error? ) -> Void )
	func signOutUser() throws
	func getTokenForCurrentUser( completion: @escaping(_ token: String?, _ error: Error? ) -> Void )
}

protocol ServiceStorable
{
	// TODO: Fill in generic storage needs.
	//
}

protocol ServiceDBManageable
{
	func createUserRecord( forUid uid: String, username: String )
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
	
	func signInUser( withToken token: FirebaseToken, completion: @escaping(_ userID: String?, _ error: Error? ) -> Void )
	{
		print( "Attempting to sign in user." )
		
		FIRAuth.auth()?.signIn( withCustomToken: token )
		{
			userOrNil, errorOrNil in
			completion( userOrNil?.uid, errorOrNil )
		}
	}
	
	func signOutUser() throws
	{
		print( "Attempting to sign out user." )
		try FIRAuth.auth()?.signOut()
	}
	
	func getTokenForCurrentUser( completion: @escaping(_ token: String?, _ error: Error? ) -> Void )
	{
		currentUser?.getTokenWithCompletion()
		{
			tokenOrNil, errorOrNil in
			completion( tokenOrNil, errorOrNil )
		}
	}
	
	// Firebase recommends to grab the current user from the auth state change handler,
	// but this should be safe, in some specific cases, e.g. `getTokenForSignedInUser()` since the user
	// will already be logged in and initialized.
	// 
	// TODO: Grab current user that has been persisted from disk.
	//
	fileprivate var currentUser: FIRUser?
	{
		return FIRAuth.auth()?.currentUser
	}
}

struct FirebaseStorageService: ServiceStorable
{
	
}

struct FirebaseDBService: ServiceDBManageable
{
	fileprivate static let FirebaseDB = FIRDatabase.database().reference()
	
	fileprivate var Users = FirebaseDB.child( Constants.FirebaseStrings.ChildUsers )
//	fileprivate var Entry = FirebaseDB.child( Constants.FirebaseStrings.ChildEntry )
//	fileprivate var DailyEntries = FirebaseDB.child( Constants.FirebaseStrings.ChildDailyEntries )
	
	func createUserRecord( forUid uid: String, username: String )
	{
		Users.child( uid ).setValue( [Constants.FirebaseStrings.DictionaryUsernameKey: username] )
		print( "Created user record in DB for uid: \( uid ), username: \( username )" )
	}
}
