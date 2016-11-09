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
    
    
    
    func onUploadImageAttempt( imageData: Data, completion: @escaping(_ error: Error? ) -> Void )
    {
        let uid = self.getUID()
        let imgPath = createImagePath( uid: uid )
        
        DispatchQueue.global( qos: .userInitiated ).async
        {
            do
            {
                self.storageService.uploadUserImage(forUid: uid, imageData: imageData, imagePath: imgPath)
                {
                    uid , error in
                    
                    completion(error)
                    
                }
            }
        }
        
    }
    
    fileprivate func getUID() -> String
    {
        let firebaseUID = dbService.getCurrentUser()
        return firebaseUID.uid
    }
    
    fileprivate func createImagePath( uid: String ) -> String
    {
        return (uid + "/\(Int(Date.timeIntervalSinceReferenceDate * 1000)).jpg")
    }
    
    fileprivate let lunaAPI = LunaAPI( requestor: LunaRequestor() )
    fileprivate let dbService: ServiceDBManageable!
    fileprivate let storageService: ServiceStorable!
}
