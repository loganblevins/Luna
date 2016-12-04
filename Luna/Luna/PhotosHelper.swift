//
//  PhotosHelper.swift
//  Luna
//
//  Created by Logan Blevins on 11/14/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Photos

struct PhotosHelper
{
	static func requestAuthorization()
	{
		PHPhotoLibrary.requestAuthorization() { _ in } 
	}
}
