//
//  AddPeriodViewModel.swift
//  Luna
//
//  Created by Erika Wilcox on 11/13/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation

class AddPeriodViewModel
{

    var Start: Date
    {
        get { return startDate! }
        
        set (newValue)
        {
            startDate = newValue
        }
    }
    
    var End: Date
    {
        get { return endDate! }
        
        set (newValue)
        {
            endDate = newValue
        }
    }
    
    var Length: Int
    {
        get { return length! }
        
        set (newValue)
        {
            length = newValue
        }
    }
    
    init( dbService: ServiceDBManageable )
    {
        self.dbService = dbService
    }
    
    
    func onCreatePeriodObject( startDate: String, endDate: String, completion: @escaping(_ error: Error? ) -> Void )
    {
        DispatchQueue.global( qos: .userInitiated ).async
        {
            guard let uid = StandardDefaults.sharedInstance.uid else
            {
                assertionFailure( "StandardDefaults returned bad uid." )
                return
            }
            
            let periodDict = self.createPeriodObject( forUid: uid, start: startDate, end: endDate )
            self.onSavePeriodDataAttempt( uid: uid, dict: periodDict )
            self.onUpdateLastCycleAttempt(uid: uid, newDate: startDate)
        }
        
    }

    fileprivate func createPeriodObject( forUid uid: String, start: String, end: String ) -> Dictionary<String, AnyObject>
    {
        return [Constants.FirebaseStrings.DictionaryPeriodStart: start as AnyObject, Constants.FirebaseStrings.DictionaryPeriodEnd: end as AnyObject, Constants.FirebaseStrings.DictionaryPeriodUid: uid as AnyObject ]
    }
    
    fileprivate func onSavePeriodDataAttempt ( uid: String, dict: Dictionary<String, AnyObject> )
    {
        self.dbService.createPeriodRecord(forUid: uid, period: dict )
    }
    
    fileprivate func onUpdateLastCycleAttempt ( uid: String, newDate: String )
    {
        self.dbService.saveUserRecord( forUid: uid, key: Constants.FirebaseStrings.DictionaryUserCycleDate, data: newDate as AnyObject )
    }

    func setDates()
    {
        guard let periodLen = StandardDefaults.sharedInstance.cycleLen else
        {
            self.length = 5
            self.startDate = Date()
            self.setEndDate()
            return
        }
        
        self.length = periodLen
        self.startDate = Date()
        self.setEndDate()

    }
    
    fileprivate func setEndDate()
    {

        let daysToAdd:Int = self.length!
        
        // Set up date components
        let dateComponents: NSDateComponents = NSDateComponents()
        dateComponents.day = daysToAdd
        
        // Create a calendar
        let gregorianCalendar: NSCalendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!
        let endDayDate: NSDate = gregorianCalendar.date(byAdding: dateComponents as DateComponents, to: self.startDate!, options:NSCalendar.Options(rawValue: 0))! as NSDate
        
        self.endDate = endDayDate as Date
    }
        
    
    fileprivate var startDate: Date?
    fileprivate var endDate: Date?
    fileprivate var length: Int?
    
    fileprivate let lunaAPI = LunaAPI( requestor: LunaRequestor() )
    fileprivate let dbService: ServiceDBManageable!
}
