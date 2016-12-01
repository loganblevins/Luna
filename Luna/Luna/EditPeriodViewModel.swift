//
//  EditPeriodViewModel.swift
//  Luna
//
//  Created by Erika Wilcox on 11/13/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation

class EditPeriodViewModel
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
    
    var Pid: String
    {
        get { return (periodViewModel?.pid)! }
        
    }
    
    init( dbService: ServiceDBManageable )
    {
        self.dbService = dbService
    }
    
    
    func onEditPeriodObject( pid: String, startDate: String, endDate: String, completion: @escaping(_ error: Error? ) -> Void )
    {
        DispatchQueue.global( qos: .userInitiated ).async
        {
            guard let uid = StandardDefaults.sharedInstance.uid else
            {
                assertionFailure( "StandardDefaults returned bad uid." )
                return
            }
                
            let periodDict = self.editPeriodObject( forUid: uid, start: startDate, end: endDate )
            self.onSavePeriodDataAttempt(pid: pid, dict: periodDict)
        }
        
    }
    
    fileprivate func editPeriodObject( forUid uid: String, start: String, end: String ) -> Dictionary<String, AnyObject>
    {
        return [Constants.FirebaseStrings.DictionaryPeriodStart: start as AnyObject, Constants.FirebaseStrings.DictionaryPeriodEnd: end as AnyObject, Constants.FirebaseStrings.DictionaryPeriodUid: uid as AnyObject ]
    }
    
    fileprivate func onSavePeriodDataAttempt ( pid: String, dict: Dictionary<String, AnyObject> )
    {
        self.dbService.updatePeriodRecord( forPid: pid, period: dict )
    }
    
    
    func setDates()
    {
        startDate = periodViewModel?.startDate
        endDate = periodViewModel?.endDate
        setLength()
    }
    
    fileprivate func setLength()
    {
        let days  = Calendar.current.dateComponents([.day], from: startDate!, to: endDate!).day
        length = days
    }
    
    func setPeriodViewModel( periodVM: PeriodViewModel )
    {
        periodViewModel = periodVM
    }
    
    
    fileprivate var startDate: Date?
    fileprivate var endDate: Date?
    fileprivate var length: Int?
    
    fileprivate let lunaAPI = LunaAPI( requestor: LunaRequestor() )
    fileprivate let dbService: ServiceDBManageable!
    fileprivate var periodViewModel: PeriodViewModel?
}
