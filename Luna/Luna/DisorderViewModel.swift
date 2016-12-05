//
//  DisorderViewModel.swift
//  Luna
//
//  Created by Erika Wilcox on 11/8/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation

class DisorderViewModel
{
    init( dbService: ServiceDBManageable )
    {
        self.dbService = dbService
    }
    
    func onAddDataAttempt( data: String? )
    {
        DispatchQueue.global( qos: .background ).async
        {
			guard let uid = StandardDefaults.sharedInstance.uid else
			{
				assertionFailure( "StandardDefaults returned bad uid." )
				return
			}

			if let data = data
			{
				self.onSaveDataAttempt( uid: uid, data: data )
			}
        }
		if let data = data
		{
			self.persist( disorder: data )
		}
    }
    
    func getDisorderData() -> String?
    {
        guard let disorder = StandardDefaults.sharedInstance.disorder else
        {
            return nil
        }
        
        return disorder
    }
    
    
    fileprivate func onSaveDataAttempt( uid: String, data: String )
    {
        self.dbService.saveUserRecord(forUid: uid, key: Constants.FirebaseStrings.DictionaryUserDisorder, data: data as AnyObject)
    }
    
    fileprivate func persist( disorder: String )
    {
        StandardDefaults.sharedInstance.disorder = disorder
    }

    fileprivate let lunaAPI = LunaAPI( requestor: LunaRequestor() )
    fileprivate let dbService: ServiceDBManageable!
    
}
