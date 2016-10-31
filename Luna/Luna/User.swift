//
//  User.swift
//  Luna
//
//  Created by Erika Wilcox on 9/23/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation
import Firebase

protocol UserDataProtocol
{
	var uid: String { get }
	var birthControl: String { get }
	var birthday: Date { get }
	var lastPeriod: Date { get }
	var height: Int { get }
	var weight: Int { get }
	var cycleLength: Int { get }
	var periodLength: Int { get }
}

struct UserData: UserDataProtocol
{
	init( uid: String,
	      birthControl: String,
	      birthday: Date,
	      lastPeriod: Date,
	      height: Int,
	      weight: Int,
	      cycleLength: Int,
		  periodLength: Int )
	{
		self.uid = uid
		self.birthControl = birthControl
		self.birthday = birthday
		self.lastPeriod = lastPeriod
		self.height = height
		self.weight = weight
		self.cycleLength = cycleLength
		self.periodLength = periodLength
	}
	
	var uid: String
	var birthControl: String
	var birthday: Date
	var lastPeriod: Date
	var height: Int
	var weight: Int
	var cycleLength: Int
	var periodLength: Int
}

final class User
{
	// MARK: Public API
	//

	init( userData: UserDataProtocol )
    {
        self.uid = userData.uid
		self.birthControl = userData.birthControl
        self.birthday = userData.birthday
		self.lastPeriod = userData.lastPeriod
        self.height = userData.height
        self.weight = userData.weight
        self.cycleLength = userData.cycleLength
        self.periodLength = userData.periodLength
	}
    
    ///This method is for posting single data to firebase
    func postDataToFirebase( _ postType: String, postData: Any )
    {
//        FirebaseService.refUsers.child( FirebaseService.refCurrentUser! ).child( postType ).setValue( postData )
    }
    
    ///This method is for posting an entire user to firebase
    func postToFirebase()
    {
//        FirebaseService.refUsers.child( FirebaseService.refCurrentUser! ).child("userID").setValue( uid )
//        FirebaseService.refUsers.child( FirebaseService.refCurrentUser! ).child("birthday").setValue( birthday )
//        FirebaseService.refUsers.child( FirebaseService.refCurrentUser! ).child("height").setValue( height )
//        FirebaseService.refUsers.child( FirebaseService.refCurrentUser! ).child("weight").setValue( weight )
//        FirebaseService.refUsers.child( FirebaseService.refCurrentUser! ).child("cycleLength").setValue( cycleLength )
//        FirebaseService.refUsers.child( FirebaseService.refCurrentUser! ).child("periodLength").setValue( periodLength )
//        FirebaseService.refUsers.child( FirebaseService.refCurrentUser! ).child("lastPeriod").setValue( lastPeriod )
//        FirebaseService.refUsers.child( FirebaseService.refCurrentUser! ).child("birthControl").setValue( birthControl )
	}
	
	// MARK: Implementation details
	//
	
	fileprivate(set) var uid: String
	fileprivate(set) var birthControl: String
	fileprivate(set) var birthday: Date
	fileprivate(set) var lastPeriod: Date
	fileprivate(set) var height: Int
	fileprivate(set) var weight: Int
	fileprivate(set) var cycleLength: Int
	fileprivate(set) var periodLength: Int
}

