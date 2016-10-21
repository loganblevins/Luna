//
//  FirebaseService.swift
//  Luna
//
//  Created by Erika Wilcox on 9/23/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Firebase

struct FirebaseService
{
	static let FIREBASE_REF = FIRDatabase.database().reference()
	static let REF_CURRENT_USER = FIRAuth.auth()?.currentUser
	
	static var refCurrentUser = REF_CURRENT_USER?.uid
	static var refUsers = FIREBASE_REF.child( Constants.FirebaseStrings.ChildUsers )
	static var refEntry = FIREBASE_REF.child( Constants.FirebaseStrings.ChildEntry )
	static var refDailyEntries = FIREBASE_REF.child( Constants.FirebaseStrings.ChildDailyEntries )
}
