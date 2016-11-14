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
	
	func fetchAssets( fromDate begin: Date, to end: Date ) -> PHFetchResult<PHAsset>
	{
		let NSBegin = begin as NSDate
		let NSEnd = end as NSDate
		let options = PHFetchOptions()
		options.includeAssetSourceTypes = .typeUserLibrary
		options.predicate = NSPredicate( format: "( creationDate >= %@ ) AND ( creationDate <= %@ )", NSBegin, NSEnd )
		let fetchResult = PHAsset.fetchAssets( with: .image, options: options )
		return fetchResult
	}
	
	static func authorized() -> Bool
	{
		let status = PHPhotoLibrary.authorizationStatus()
		return status == .authorized
	}
	
	fileprivate func dataFromAsset( asset: PHAsset ) -> Data?
	{
		var imageData: Data?
		let manager = PHImageManager.default()
		let options = PHImageRequestOptions()
		options.isSynchronous = true
		options.version = .original
		manager.requestImageData( for: asset, options: options )
		{
			data, response, orientation, info in
			
			imageData = data
		}
		return imageData
	}
}
