//
//  Constants.swift
//  Luna
//
//  Created by Logan Blevins on 9/16/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Firebase

struct Constants
{
	let SEGUE_START_ONBOARD = "startOnboard"
    
    let SEGUE_TO_HEIGHT = "toHeight"
	
//	struct IBStrings
//	{
//		
//	}
//	
//	struct FirebaseAPIStrings
//	{
//		static let baseURL = "https://luna-c2c2f.firebaseio.com"
//	}
//	
//	struct LunaAPIStrings
//	{
//		static let baseURL = "http://luna-track.com/api/v1/"
//	}
//	

	let baseURL = "http://luna-track.com/api/v1/"

	let FirebaseBaseURL = "https://luna-c2c2f.firebaseio.com"
	
	
}


let FIREBASE_REF = FIRDatabase.database().reference()

let REF_CURRENT_USER = FIRAuth.auth()?.currentUser

class FirebaseService
{
	
	var refCurrentUser = REF_CURRENT_USER?.uid
	
	var refUsers = FIREBASE_REF.child("Users")
	
	var refDailyEntries = FIREBASE_REF.child("DailyEntries")
	
	var refEntry = FIREBASE_REF.child("Entry")
	


}
