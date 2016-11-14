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
	
	static func fetchAssets( fromDate begin: Date, to end: Date )
	{
		let NSBegin = begin as NSDate
		let NSEnd = end as NSDate
		let options = PHFetchOptions()
		options.predicate = NSPredicate( format: "( creationDate >= %@ ) AND ( creationDate <= %@ )", [NSBegin, NSEnd] )
		let fetchResult = PHAsset.fetchAssets( with: .image, options: options )
		fetchResult.enumerateObjects(
		{
			asset, index, stop in
			
			print( index )
		} )
	}
	
	static func authorized() -> Bool
	{
		let status = PHPhotoLibrary.authorizationStatus()
		return status == .authorized
	}
}
