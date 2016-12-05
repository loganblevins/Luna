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
    
    func onAddDataAttempt( data: String )
    {
        DispatchQueue.global( qos: .background ).async
        {
			guard let uid = StandardDefaults.sharedInstance.uid else
			{
				assertionFailure( "StandardDefaults returned bad uid." )
				return
			}

			self.onSaveDataAttempt( uid: uid, data: data )
        }
		self.persist( birthcontrol: data )
    }
    
    func getBirthControlData() -> String?
    {
        guard let birthCtrl = StandardDefaults.sharedInstance.birthCtrl else
        {
            return nil
        }
        
        return birthCtrl
    }
    
    fileprivate func onSaveDataAttempt( uid: String, data: String )
    {
       self.dbService.saveUserRecord(forUid: uid, key: Constants.FirebaseStrings.DictionaryUserBirthControl, data: data as AnyObject)
    }
    
    func getPickerValues() -> [String]
    {
       return pickerViewData.createBirthControlPicker()
    }
    
    fileprivate func persist( birthcontrol: String )
    {
        StandardDefaults.sharedInstance.birthCtrl = birthcontrol
    }
    
    
    fileprivate var pickerViewData = PickerViews()
    fileprivate let lunaAPI = LunaAPI( requestor: LunaRequestor() )
    fileprivate let dbService: ServiceDBManageable!

}
