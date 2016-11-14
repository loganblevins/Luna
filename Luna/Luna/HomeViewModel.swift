//
//  HomeViewModel.swift
//  Luna
//
//  Created by Erika Wilcox on 11/12/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation

class HomeViewModel
{
    var LastCycleDate: Date
    {
        get { return lastCycleDate! }
        
        set (newValue)
        {
            lastCycleDate = newValue
        }
    }
    
    var ExpectedOvulationDate: Date
        {
        get { return expectedOvulation! }
        
        set (newValue)
        {
            expectedOvulation = newValue
        }
    }
    
    var ExpectedPeriodDate: Date
    {
        get { return expectedPeriod! }
        
        set (newValue)
        {
            expectedPeriod = newValue
        }
    }
    
    var DaysToPeriod: Int
    {
        get { return daysToExpectedPeriod! }
        
        set (newValue)
        {
            daysToExpectedPeriod = newValue
        }
    }
    
    
    init( withAuthService authService: ServiceAuthenticatable, dbService: ServiceDBManageable )
    {
        self.authService = authService
        self.dbService = dbService
        
        currentViewDate = Date()
    }
    
    func saveUserDailyEntry(completion: @escaping(_ error: Error?, _ status: Bool? ) -> Void )
    {
        // Put network request on background thread.
        //
        DispatchQueue.global( qos: .userInitiated ).async
        {
            guard StandardDefaults.sharedInstance.uid != nil else
            {
                assertionFailure( "StandardDefaults returned bad uid." )
                return
            }
        }
    }
    
    func setCurrentDate( date: Date )
    {
        currentViewDate = date
    }
    
    func returnCurrentDate() -> Date
    {
        return currentViewDate
    }
    
    func setDates( completion: @escaping(_ error: Error? ) -> Void )
    {
        getUserLastCycleDate()
        {
            errorOrNil in
                
            guard errorOrNil == nil else
            {
                //Set the default if there is an error
                self.LastCycleDate = Date()
                
                self.setExpectedPeriodDate()
                self.setExpectedOvulation()
                self.setDaysToExpectedPeriod()
                return
            }
            
            self.setExpectedPeriodDate()
            self.setExpectedOvulation()
            self.setDaysToExpectedPeriod()
            
            completion( nil )
        }
    }
    
    fileprivate func getUserLastCycleDate( completion: @escaping(_ error: Error? ) -> Void )
    {
        guard let uid = StandardDefaults.sharedInstance.uid else
        {
            assertionFailure( "StandardDefaults returned bad uid." )
            return
        }
        
        self.dbService.getLastPeriodDate( forUid: uid )
        {
            errorOrNil, lastOrNil in
            
            if (lastOrNil != nil)
            {
                self.lastCycleDate = self.convertStringToDate( dateString: lastOrNil! )
                completion ( nil )
            }
            else
            {
                completion ( errorOrNil )
            }
        }
        
    }
    
    fileprivate func convertStringToDate( dateString: String ) -> Date
    {
  
        let string : String = dateString
        
        let timeinterval : TimeInterval = (string as NSString).doubleValue // convert it in to NSTimeInteral
        
        let dateFromServer = NSDate( timeIntervalSince1970:timeinterval ) as Date // you can the Date object from here
        
        print(dateFromServer)
        
        
        return dateFromServer

    }
    
    fileprivate func setDaysToExpectedPeriod()
    {
        let days  = Calendar.current.dateComponents([.day], from: Date(), to: self.expectedPeriod!).day
        self.daysToExpectedPeriod = days
    }
    
    fileprivate func setExpectedPeriodDate()
    {
        self.expectedPeriod = Calendar.current.date(byAdding: .day, value: 28, to: lastCycleDate!)
        print(expectedPeriod!)
    }
    
    fileprivate func setExpectedOvulation()
    {
        
        self.expectedOvulation = Calendar.current.date(byAdding: .day, value: 14, to: lastCycleDate!)
        print(expectedOvulation!)
    }
    
    
    fileprivate var currentViewDate: Date
    
    fileprivate var lastCycleDate: Date?
    fileprivate var daysToExpectedPeriod: Int?
    fileprivate var expectedPeriod: Date?
    fileprivate var expectedOvulation: Date?
    
    fileprivate let lunaAPI = LunaAPI( requestor: LunaRequestor() )
    fileprivate let authService: ServiceAuthenticatable!
    fileprivate let dbService: ServiceDBManageable!
}
