//
//  AddImageViewModel.swift
//  Luna
//
//  Created by Erika Wilcox on 11/7/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation

class AddImageViewModel
{
    init( dbService: ServiceDBManageable, storageService: ServiceStorable)
    {
        self.dbService = dbService
        self.storageService = storageService
    }
    
    
    func onUploadImageAttempt( uid:String, imageData: Data, completion: @escaping(_ error: Error? ) -> Void )
    {
        
        DispatchQueue.global( qos: .userInitiated ).async
        {
            do
            {
                self.storageService.uploadUserImage(forUid: uid, imageData: imageData, imagePath: "")
                {
                    uid , error in
                    
                    completion(error)
                    
                }
            }
        }
        
    }
    
    fileprivate let lunaAPI = LunaAPI( requestor: LunaRequestor() )
    fileprivate let dbService: ServiceDBManageable!
    fileprivate let storageService: ServiceStorable!
}
