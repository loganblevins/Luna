//
//  BirthControlViewModel.swift
//  Luna
//
//  Created by Erika Wilcox on 11/8/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation

class BirthControlViewModel
{
    init( dbService: ServiceDBManageable )
    {
        self.dbService = dbService
    }
    
    func onAddDataAttempt( data: String, completion: @escaping(_ error: Error? ) -> Void )
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
        let firebaseUID = dbService.getCurrentUser()
        return firebaseUID.uid
    }
    
    fileprivate func onSaveDataAttempt( uid: String, data: String )
    {
       self.dbService.saveUserRecord(forUid: uid, key: Constants.FirebaseStrings.DictionaryUserBirthControl, data: data as AnyObject)
    }
    
    func getPickerValues() -> [String]
    {
       return pickerViewData.createBirthControlPicker()
    }
    
    fileprivate var pickerViewData = PickerViews()
    fileprivate let lunaAPI = LunaAPI( requestor: LunaRequestor() )
    fileprivate let dbService: ServiceDBManageable!

}