//
//  PhotoFetcher.swift
//  Luna
//
//  Created by Logan Blevins on 11/13/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Photos

struct PhotoFetcher
{
	static func requestAuthorization()
	{
		PHPhotoLibrary.requestAuthorization() { _ in }
	}
	
	func fetchAssets( fromDate begin: Date, to end: Date )
	{
		let NSBegin = begin as NSDate
		let NSEnd = end as NSDate
		let options = PHFetchOptions()
		options.includeAssetSourceTypes = .typeUserLibrary
		options.predicate = NSPredicate( format: "( creationDate >= %@ ) AND ( creationDate <= %@ )", NSBegin, NSEnd )
		let fetchResult = PHAsset.fetchAssets( with: .image, options: options )
		fetchResult.enumerateObjects(
		{
			asset, index, stop in
			
				let image = self.imageFromAsset( asset: asset )
				let data = UIImageJPEGRepresentation( image!, 0.0 )
				self.onUploadImageAttempt( imageData: data! )
				{
					error in
					
				}
			
		
			print( index )
		} )
	}
	
	static func authorized() -> Bool
	{
		let status = PHPhotoLibrary.authorizationStatus()
		return status == .authorized
	}
	
	
	func onUploadImageAttempt( imageData: Data, completion: @escaping(_ error: Error? ) -> Void )
	{
		guard let uid = StandardDefaults.sharedInstance.uid else
		{
			assertionFailure( "Bad uid." )
			return
		}
		let imgPath = createImagePath( uid: uid )
		
		DispatchQueue.global( qos: .background ).async
			{
				self.storageService.uploadUserImage(forUid: uid, imageData: imageData, imagePath: imgPath)
				{
					_, error in
					
					completion(error)
				}
		}
	}
	
	fileprivate func createImagePath( uid: String ) -> String
	{
		return (uid + "/\(Int(Date.timeIntervalSinceReferenceDate * 1000)).jpg")
	}
	
	fileprivate func imageFromAsset( asset: PHAsset ) -> UIImage?
	{
		var image: UIImage?
		let manager = PHImageManager.default()
		let options = PHImageRequestOptions()
		options.isSynchronous = true
		manager.requestImage( for: asset, targetSize: CGSize( width: 100, height: 100 ), contentMode: .aspectFit, options: options )
		{
			result, info in
			
			image = result
		}
		return image
	}
	
	fileprivate let storageService: ServiceStorable = FirebaseStorageService()
}
