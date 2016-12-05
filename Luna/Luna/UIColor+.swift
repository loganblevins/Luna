//
//  UIColor+.swift
//  Luna
//
//  Created by Logan Blevins on 12/4/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

extension UIColor
{
	convenience init(_ rgbHex: UInt, alpha: CGFloat = 1.0 )
	{
		let rawRed = Double( ( rgbHex >> 16 ) & 0xFF ) / 255.0
		let rawGreen = Double( ( rgbHex >> 8 ) & 0xFF ) / 255.0
		let rawBlue = Double( rgbHex & 0xFF ) / 255.0
		self.init(red: CGFloat( rawRed ), green: CGFloat( rawGreen ), blue: CGFloat( rawBlue ), alpha: alpha )
	}
}
