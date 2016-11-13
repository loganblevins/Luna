//
//  RetrieveService.swift
//  Luna
//
//  Created by Mazin Zakaria on 11/12/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Photos
import UIKit
import Foundation

class RetrieveViewModel
{
    
    @IBOutlet weak var img: UIImageView!

    init( dbService: ServiceDBManageable, storageService: ServiceStorable)
    {
        self.dbService = dbService
        self.storageService = storageService
    }
    
    var images:NSMutableArray! // <-- Array to hold the fetched images
    
    func fetchPhotos () {
        
        images = NSMutableArray()
        self.fetchPhotoAtIndexFromEnd(index: 0)
  

    }
    
    // Repeatedly call the following method while incrementing
    // the index until all the photos are fetched
    func fetchPhotoAtIndexFromEnd(index:Int) {
        
        let imgManager = PHImageManager.default()
        
        // Note that if the request is not set to synchronous
        // the requestImageForAsset will return both the image
        // and thumbnail; by setting synchronous to true it
        // will return just the thumbnail
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        
        // Sort the images by creation date
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: true)]
        
        if let fetchResult: PHFetchResult<PHAsset> = PHAsset.fetchAssets(with: fetchOptions) {
            
            // If the fetch result isn't empty,
            // proceed with the image request
            if fetchResult.count > 0 {
                // Perform the image request
                imgManager.requestImageData(for: fetchResult.objectAtIndex(fetchResult.count - 1 - index), options: requestOptions, resultHandler: { (image, _) in
                    
                    // Add the returned image to your array
                    self.images.addObject(image!)
                    
                    // If you haven't already reached the first
                    // index of the fetch result and if you haven't
                    // already stored all of the images you need,
                    // perform the fetch request again with an
                    // incremented index
                    
                    if index + 1 < fetchResult.count
                    {
                        
                        self.fetchPhotoAtIndexFromEnd(index + 1)
                    } else {
                        // Else you have completed creating your array
                        print("Completed array: \(self.images)")
                        self.maxCount = Double(self.images.count)
                    }
                })
            }
        }
        
        }
    
    func onUploadImageAttempt( imageData: Data, completion: @escaping(_ error: Error? ) -> Void )
    {
        let uid = getUID()
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
        return StandardDefaults.sharedInstance.uid!
    }
    
    fileprivate func createImagePath( uid: String ) -> String
    {
        return (uid + "/\(Int(Date.timeIntervalSinceReferenceDate * 1000)).jpg")
    }
    
    fileprivate let lunaAPI = LunaAPI( requestor: LunaRequestor() )
    fileprivate let dbService: ServiceDBManageable!
    fileprivate let storageService: ServiceStorable!


}
