//
//  String+.swift
//  Luna
//
//  Created by Logan Blevins on 9/16/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation

extension String
{
	func trimmed() -> String
	{
		return trimmingCharacters( in: CharacterSet.whitespaces )
	}
	
	func contains( find: String ) -> Bool
	{
		return range( of: find ) != nil
	}
	
	var count: Int
	{
		return utf16.count
	}
}
