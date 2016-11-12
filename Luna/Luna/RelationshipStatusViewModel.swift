//
//  RelationshipStatusViewModel.swift
//  Luna
//
//  Created by Erika Wilcox on 11/8/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation

class RelationshipStatusViewModel
{
    init( dbService: ServiceDBManageable )
    {
        self.dbService = dbService
    }
    
    func onAddDataAttempt( data: String, completion: @escaping(_ error: Error? ) -> Void )
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

    
    fileprivate func onSaveDataAttempt( uid: String, data: String )
    {
        self.dbService.saveUserRecord(forUid: uid, key: Constants.FirebaseStrings.DictionaryUserRelationshipStatus, data: data as AnyObject)
    }
    
    func getPickerValues() -> [String]
    {
        return pickerViewData.createRelationStatusPicker()
    }
    
    fileprivate var pickerViewData = PickerViews()
    fileprivate let lunaAPI = LunaAPI( requestor: LunaRequestor() )
    fileprivate let dbService: ServiceDBManageable!
    
}
