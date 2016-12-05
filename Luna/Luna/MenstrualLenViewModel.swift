//
//  MenstrualLenViewModel.swift
//  Luna
//
//  Created by Erika Wilcox on 11/8/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation

class MenstrualLenViewModel
{
    init( dbService: ServiceDBManageable )
    {
        self.dbService = dbService
    }
    
    func onAddDataAttempt( data: Int )
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
		self.persist( len: data )
    }
	
    func getLengthData() -> Int?
    {
        guard let len = StandardDefaults.sharedInstance.cycleLen else
        {
            return nil
        }
        
        return len
    }
    
    fileprivate func onSaveDataAttempt( uid: String, data: Int )
    {
        self.dbService.saveUserRecord(forUid: uid, key: Constants.FirebaseStrings.DictionaryUserMenstrualLen, data: data as AnyObject)
    }
    
    fileprivate func persist( len: Int )
    {
        StandardDefaults.sharedInstance.cycleLen = len
    }
    
    func getPickerValues() -> [String]
    {
        return pickerViewData.createPeriodLengths()
    }
    
    fileprivate var pickerViewData = PickerViews()
    fileprivate let lunaAPI = LunaAPI( requestor: LunaRequestor() )
    fileprivate let dbService: ServiceDBManageable!

}
