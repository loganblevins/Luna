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
//	fileprivate func fetchAll() -> [PHAsset]
//	{
//		let fetchResult = PHAsset.fetchAssets( with: .image, options: nil )
//	}
//	
//	fileprivate let manager = PHImageManager.default()
	
	static func requestAuthorization()
	{
		PHPhotoLibrary.requestAuthorization() { _ in }
	}
}
//
//- (void)setup
//	{
//		self.recentsDataSource = [[NSMutableOrderedSet alloc]init];
//		self.favoritesDataSource = [[NSMutableOrderedSet alloc]init];
//		
//		PHFetchResult *assetCollection = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum | PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAny options:nil];
//		
//		PHFetchResult *favoriteCollection = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumFavorites options:nil];
//		
//		for (PHAssetCollection *sub in assetCollection)
//		{
//			PHFetchResult *assetsInCollection = [PHAsset fetchAssetsInAssetCollection:sub options:nil];
//			
//			for (PHAsset *asset in assetsInCollection)
//			{
//				[self.recentsDataSource addObject:asset];
//			}
//		}
//		
//		if (self.recentsDataSource.count > 0)
//		{
//			NSArray *array = [self.recentsDataSource sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]]];
//			
//			self.recentsDataSource = [[NSMutableOrderedSet alloc]initWithArray:array];
//		}
//		
//		for (PHAssetCollection *sub in favoriteCollection)
//		{
//			PHFetchResult *assetsInCollection = [PHAsset fetchAssetsInAssetCollection:sub options:nil];
//			
//			for (PHAsset *asset in assetsInCollection)
//			{
//				[self.favoritesDataSource addObject:asset];
//			}
//		}
//		
//		if (self.favoritesDataSource.count > 0)
//		{
//			NSArray *array = [self.favoritesDataSource sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]]];
//			
//			self.favoritesDataSource = [[NSMutableOrderedSet alloc]initWithArray:array];
//		}
//}
