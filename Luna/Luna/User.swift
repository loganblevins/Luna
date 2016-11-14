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
    var lastCycle: Date { get }
    var cycleLength: Int { get }
    var relationshipStatus: String { get }
    var disorder: String { get }
}

struct UserData: UserDataProtocol
{
    init( uid: String,
          birthControl: String,
          lastCycle: Date,
          cycleLength: Int,
          relationshipStatus: String,
          disorder: String)
    {
        self.uid = uid
        self.birthControl = birthControl
        self.lastCycle = lastCycle
        self.cycleLength = cycleLength
        self.relationshipStatus = relationshipStatus
        self.disorder = disorder
    }
    
    var uid: String
    var birthControl: String
    var lastCycle: Date
    var cycleLength: Int
    var relationshipStatus: String
    var disorder: String
}

final class User
{
	// MARK: Public API
	//

    init( userData: UserDataProtocol )
    {
        self.uid = userData.uid
        self.birthControl = userData.birthControl
        self.lastCycle = userData.lastCycle
        self.cycleLength = userData.cycleLength
        self.relationshipStatus = userData.relationshipStatus
        self.disorder = userData.disorder
    }
    
    // MARK: Implementation details
    //
    
    fileprivate(set) var uid: String
    fileprivate(set) var birthControl: String
    fileprivate(set) var lastCycle: Date
    fileprivate(set) var cycleLength: Int
    fileprivate(set) var relationshipStatus: String
    fileprivate(set) var disorder: String
}

