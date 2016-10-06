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
		self.viewModel = viewModel
	}
	
	fileprivate let viewModel: CalendarViewModel
}
