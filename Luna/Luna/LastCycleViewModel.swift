//
//  LastCycleViewModel.swift
//  Luna
//
//  Created by Erika Wilcox on 11/8/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation

class LastCycleViewModel
{
    init( dbService: ServiceDBManageable )
    {
        self.dbService = dbService
    }
    
    func onAddDataAttempt( data: Date, completion: @escaping(_ error: Error? ) -> Void )
    {
        let uid = getUID()
        
        DispatchQueue.global( qos: .userInitiated ).async
        {
            do
            {
                self.onSaveDataAttempt( uid: uid, data: data )
            }
        }
    }
    
    fileprivate func getUID() -> String
    {
        return StandardDefaults.sharedInstance.uid!
    }
    
    fileprivate func onSaveDataAttempt( uid: String, data: Date )
    {
        self.dbService.saveUserRecord(forUid: uid, key: Constants.FirebaseStrings.DictionaryUserCycleDate, data: data as AnyObject)
    }
    
    fileprivate func convertDateFormat( date: Date )
    {
    
    }
    

    fileprivate let lunaAPI = LunaAPI( requestor: LunaRequestor() )
    fileprivate let dbService: ServiceDBManageable!
    
}
