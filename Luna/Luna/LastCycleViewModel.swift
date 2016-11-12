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
        DispatchQueue.global( qos: .userInitiated ).async
        {
            do
            {
                guard let uid = StandardDefaults.sharedInstance.uid else
                {
                    assertionFailure( "StandardDefaults returned bad uid." )
                    return
                }

                self.onSaveDataAttempt( uid: uid, data: data )
            }
        }
    }
    
    fileprivate func onSaveDataAttempt( uid: String, data: Date )
    {
        let timestamp = convertDateFormatToString(date: data)
        
        self.dbService.saveUserRecord( forUid: uid, key: Constants.FirebaseStrings.DictionaryUserCycleDate, data: timestamp as AnyObject )
    }
    
    fileprivate func convertDateFormatToString( date: Date ) -> String
    {
        let timestamp = date.timeIntervalSince1970
        
        return String(format: "%f", timestamp)
    }
    

    fileprivate let lunaAPI = LunaAPI( requestor: LunaRequestor() )
    fileprivate let dbService: ServiceDBManageable!
    
}
