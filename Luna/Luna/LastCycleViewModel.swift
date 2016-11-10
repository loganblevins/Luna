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
        
        let date = convertDateFormat(date: data)
        
        DispatchQueue.global( qos: .userInitiated ).async
        {
            do
            {
               self.onSaveDataAttempt( uid: uid, data: date )
            }
        }
    }
    
    fileprivate func getUID() -> String
    {
        let firebaseUID = dbService.getCurrentUser()
        return firebaseUID.uid
    }
    
    fileprivate func onSaveDataAttempt( uid: String, data: String )
    {
        self.dbService.saveUserRecord(forUid: uid, key: Constants.FirebaseStrings.DictionaryUserCycleDate, data: data as AnyObject)
    }
    
    fileprivate func convertDateFormat( date: Date ) -> String
    {
        let timestamp = date.timeIntervalSince1970
        
        let ret = String(format:"%f", timestamp)
        
        return ret
    }
    

    fileprivate let lunaAPI = LunaAPI( requestor: LunaRequestor() )
    fileprivate let dbService: ServiceDBManageable!
    
}
