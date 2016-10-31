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
	func signOutUser( completion: @escaping(_ error: Error? ) -> Void )
	
	var currentUser: FIRUser? { get }
}

protocol ServiceStorable
{
	
}

protocol ServiceDBManageable
{
	
}

struct FirebaseAuthenticationService: ServiceAuthenticatable
{
	func signInUser( withToken token: FirebaseToken, completion: @escaping(_ error: Error? ) -> Void)
	{
		FIRAuth.auth()?.signIn( withCustomToken: token )
		{
			user, error in
			
			completion( error )
		}
	}
	
	func signOutUser( completion: @escaping(_ error: Error? ) -> Void )
	{
		do
		{
			try FIRAuth.auth()?.signOut()
			completion( nil )
		}
		catch
		{
			completion( error )
		}
	}
	
	var currentUser: FIRUser?
	{
		return nil
	}
}

struct FirebaseStorageService: ServiceStorable
{
	
}

struct FirebaseDBService: ServiceDBManageable
{
	fileprivate let FirebaseDB = FIRDatabase.database().reference()
	
//	fileprivate var Users = FirebaseDB.child( Constants.FirebaseStrings.ChildUsers )
//	fileprivate var Entry = FirebaseDB.child( Constants.FirebaseStrings.ChildEntry )
//	fileprivate var DailyEntries = FirebaseDB.child( Constants.FirebaseStrings.ChildDailyEntries )
}
