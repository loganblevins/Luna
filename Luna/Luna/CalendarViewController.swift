//
//  CalendarViewController.swift
//  Luna
//
//  Created by Logan Blevins on 10/5/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit
import CVCalendar

final class CalendarViewController: UIViewController, CVCalendarViewDelegate, CVCalendarMenuViewDelegate
{
	override func viewDidLayoutSubviews()
	{
		super.viewDidLayoutSubviews()
		
		menuView.commitMenuViewUpdate()
		calendarView.commitCalendarViewUpdate()
	}
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		updateNavigationBarTitle()
	}
	
	func presentationMode() -> CalendarMode
	{
		return .monthView
	}
	
	func firstWeekday() -> Weekday
	{
		return .sunday
	}
	
	func presentedDateUpdated(_ date: CVDate )
	{
		print( "presentedDateUpdated: \(date.commonDescription)" )
		updateNavigationBarTitle()
	}
	
	func shouldAnimateResizing() -> Bool
	{
		return false
	}
	
	fileprivate func updateNavigationBarTitle()
	{
		self.navBarTopItem.title = calendarView.presentedDate.globalDescription
	}
	
	fileprivate var navBarTopItem: UINavigationItem!
	{
		return self.navigationController?.navigationBar.topItem
	}
	
	@IBOutlet weak var menuView: CVCalendarMenuView!
	@IBOutlet weak var calendarView: CVCalendarView!
}
