//
//  SettingsPeriodsViewModel.swift
//  Luna
//
//  Created by Erika Wilcox on 11/13/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation

class SettingsPeriodsViewModel
{
    init( databaseService: ServiceDBManageable )
    {
        self.databaseService = databaseService
    }
    
    fileprivate func createPeriodData( pid: String, period: Dictionary<String, AnyObject>) -> Period
    {
        let pid = pid
        var uid = ""
        var startDate: Date = NSDate() as Date
        var endDate: Date = NSDate() as Date
        
        
        if let puid = period[Constants.FirebaseStrings.DictionaryPeriodUid] as? String
        {
            uid = puid
        }
        
        if let sd = period[Constants.FirebaseStrings.DictionaryPeriodStart] as? String
        {
            startDate = convertDate(date: sd)
        }
        
        if let ed = period[Constants.FirebaseStrings.DictionaryPeriodEnd] as? String
        {
            endDate = convertDate(date: ed)
        }
        
        let periodData: PeriodData = PeriodData( pid: pid, uid: uid, startDate: startDate, endDate: endDate )
        
        return Period( periodData: periodData )
        
    }

    
    func getPeriods( completion: @escaping(_ error: Error? ) -> Void )
    {
        guard let uid = StandardDefaults.sharedInstance.uid else
        {
            assertionFailure( "StandardDefaults returned bad uid." )
            return
        }
        
        databaseService.returnPeriodIds(forUid: uid)
        {
            errorOrNil, dictOrNil in
            
            guard errorOrNil == nil else
            {
                completion( errorOrNil )
                return
            }
            
            guard dictOrNil != nil else
            {
                return
            }
            
            self.periods = []
            
            self.getPeriodObjects(periodDict: dictOrNil)
            {
                errorONil in
                
                guard errorONil == nil else
                {
                    completion ( errorOrNil )
                    return
                }
                
                completion( nil )
            }
        }
    }
    
    func getPeriodObjects( periodDict: Dictionary<String, AnyObject>? , completion: @escaping(_ error: Error? ) -> Void )
    {
        if(periodDict != nil)
        {
            for item in periodDict!
            {
                self.createPeriodViewModel( pid: item.key )
                {
                    errorOrNil, periodOrNil in
                    
                    guard errorOrNil == nil else
                    {
                        completion ( errorOrNil )
                        return
                    }
                    
                    guard periodOrNil != nil else
                    {
                        completion ( nil )
                        return
                    }
                    
                    self.periods.append( periodOrNil! )
                    print(self.periods)
                    
                    completion( nil )
                    
                }
            }
        }
        
    }
    
    fileprivate func createPeriodViewModel( pid: String, completion: @escaping(_ error: Error?, _ periodViewModel: PeriodViewModel? ) -> Void )
    {
        
        self.databaseService.returnPeriodObject( forPid: pid )
        {
            errorOrNil, periodOrNil in
            
            guard periodOrNil != nil else
            {
                completion( nil, nil )
                return
            }
            
            let period = self.createPeriodData( pid: pid, period: periodOrNil! )
            let periodViewModel = PeriodViewModel ( period: period )
            completion ( nil, periodViewModel )
            
        }
    }
    
    fileprivate func convertDate( date: String ) -> Date
    {
        let time = (date as NSString).doubleValue
        
        return Date( timeIntervalSince1970: time )
    }
    
    var periods: [PeriodViewModel] = []
    
    fileprivate let databaseService: ServiceDBManageable!
    
}
