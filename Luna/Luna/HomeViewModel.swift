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
    
    
    func setCurrentDate( date: Date )
    {
        currentViewDate = date
    }
    
    func returnCurrentDate() -> Date
    {
        return currentViewDate
    }
    
    
    func upDateView()
    {
        guard let lastDate = StandardDefaults.sharedInstance.lastCycle else
        {
            return
        }
        
        if lastDate != lastCycleDate
        {
            setDates()
        }
    }
    
    func persist( last: Date )
    {
        StandardDefaults.sharedInstance.lastCycle = last
    }
    
    
    func setDates()
    {
        
        guard let lastDate = StandardDefaults.sharedInstance.lastCycle else
        {
            assertionFailure( "StandardDefaults returned bad date." )
            return
        }
        
        self.lastCycleDate = lastDate
        
        guard self.lastCycleDate != nil else
        {
            self.lastCycleDate = Date()
            self.setExpectedPeriodDate()
            self.setExpectedOvulation()
            self.setDaysToExpectedPeriod()
            return
            
        }
        
        self.setExpectedPeriodDate()
        self.setExpectedOvulation()
        self.setDaysToExpectedPeriod()
        
    }
    
    
    fileprivate func setDaysToExpectedPeriod()
    {
        let days  = Calendar.current.dateComponents([.day], from: Date(), to: self.expectedPeriod!).day
        self.daysToExpectedPeriod = days! + 1
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
