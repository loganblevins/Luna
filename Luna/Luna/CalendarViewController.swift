//
//  CalendarViewController.swift
//  Luna
//
//  Created by Logan Blevins on 10/5/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

final class CalendarViewController: UIViewController
{
	init( viewModel: CalendarViewModel )
	{
		super.init( nibName: nil, bundle: nil )
		self.viewModel = viewModel
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		super.init( coder: aDecoder )
	}
	
	fileprivate var viewModel: CalendarViewModel?
}
