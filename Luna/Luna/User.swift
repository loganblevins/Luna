//
//  User.swift
//  Luna
//
//  Created by Erika Wilcox on 9/23/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation
import Firebase

class User {
    
    fileprivate var _userID: String!
    fileprivate var _birthday: Date!
    fileprivate var _height: Int!
    fileprivate var _weight: Int!
    fileprivate var _cycleLen: Int!
    fileprivate var _periodLen: Int!
    fileprivate var _lastPeriod: Date!
    fileprivate var _birthCtrl: String!
    fileprivate var _dataService: FirebaseService
    
    
    var dataService: FirebaseService
    {
        return _dataService
    }
    
    var userID: String
    {
        return _userID
    }
    
    var birthday: Date
    {
        return _birthday
    }
    
    var height: Int
    {
        return _height
    }
    
    var weight : Int
    {
        return _weight
    }
    
    var cycleLen: Int
    {
        return _cycleLen
    }
    
    var periodLen: Int
    {
        return _periodLen
    }
    
    var lastPeriod: Date
    {
        return _lastPeriod
    }
    
    var birthCtrl: String
    {
        return _birthCtrl
    }
    
    init( userID: String, birthday: Date, height: Int, weight: Int, cycleLen: Int, periodLen: Int, lastPeriod: Date, birthctrl: String )
    {
        self._userID = userID
        self._birthday = birthday
        self._height = height
        self._weight = weight
        self._cycleLen = cycleLen
        self._periodLen = periodLen
        self._lastPeriod = lastPeriod
        self._birthCtrl = birthctrl
        
        
        self._dataService = FirebaseService()
    }
    
    init( userID: String, dictionary: Dictionary<String, AnyObject> )
    {
        self._userID = userID
        
        if let bDate = dictionary["birthday"] as? Date
        {
            self._birthday = bDate
        }
        
        if let hght = dictionary["height"] as? Int
        {
            self._height = hght
        }
        
        if let wght = dictionary["weight"] as? Int
        {
            self._weight = wght
        }
        
        if let cLen = dictionary["cycleLength"] as? Int
        {
            self._cycleLen = cLen
        }
        
        if let pLen = dictionary["periodLength"] as? Int
        {
            self._periodLen = pLen
        }
        
        if let lPeriod = dictionary["lastPeriod"] as? Date
        {
            self._lastPeriod = lPeriod
        }
        
        if let bCtrl = dictionary["birthControl"] as? String
        {
            self._birthCtrl = bCtrl
        }
        
        self._dataService = FirebaseService()
        
    }
    
    
    ///This method is for posting single data to firebase
    func postDataToFirebase ( postType: String, postData: AnyObject )
    {
        dataService.refUsers.child((dataService.refCurrentUser)!).child(postType).setValue(postData)
    }
    
    ///This method is for posting an entire user to firebase
    func postToFirbase ()
    {
        dataService.refUsers.child((dataService.refCurrentUser)!).child("userID").setValue(userID)
        
        dataService.refUsers.child((dataService.refCurrentUser)!).child("birthday").setValue(birthday)
        
        dataService.refUsers.child((dataService.refCurrentUser)!).child("height").setValue(height)
        
        dataService.refUsers.child((dataService.refCurrentUser)!).child("weight").setValue(weight)
        
        dataService.refUsers.child((dataService.refCurrentUser)!).child("cycleLength").setValue(cycleLen)
        
        dataService.refUsers.child((dataService.refCurrentUser)!).child("periodLength").setValue(periodLen)
        
        dataService.refUsers.child((dataService.refCurrentUser)!).child("lastPeriod").setValue(lastPeriod)
        
        dataService.refUsers.child((dataService.refCurrentUser)!).child("birthControl").setValue(birthCtrl)
        
    }
    
}

