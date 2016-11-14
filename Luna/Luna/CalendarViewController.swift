//
//  CalendarViewController.swift
//  Luna
//
//  Created by Logan Blevins on 10/5/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit
import CVCalendar

final class CalendarViewController: UIViewController, CVCalendarViewDelegate, CVCalendarMenuViewDelegate, CVCalendarViewAppearanceDelegate
{
 
	override func viewDidLayoutSubviews()
	{
		super.viewDidLayoutSubviews()
		
		menuView.commitMenuViewUpdate()
	}
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		updateNavigationBarTitle()
        calendarViewModel.setDates(){
            errorOrNil in
            
            guard errorOrNil == nil else
            {
                return
            }
            self.setColors()
            self.displayDates()
            self.calendarView.commitCalendarViewUpdate()

        }


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
    
    func shouldAutoSelectDayOnMonthChange() -> Bool {
        return true
    }
	
    func displayDates()
    {
        self.calendarView.toggleViewWithDate((calendarViewModel.ExpectedPeriodDate))

    }
    
    func setColors()
    {
        self.calendarView.appearance.dayLabelWeekdaySelectedBackgroundColor = UIColor(red: 246/255, green: 70/255, blue: 74/255, alpha: 1)
        self.calendarView.appearance.dayLabelPresentWeekdaySelectedBackgroundColor = UIColor(colorLiteralRed: 175/255, green: 175/255, blue: 175/255, alpha: 1)
    }
    
    
	fileprivate var navBarTopItem: UINavigationItem!
	{
		return self.navigationController?.navigationBar.topItem
	}
	
    
	@IBOutlet weak var menuView: CVCalendarMenuView!
	@IBOutlet weak var calendarView: CVCalendarView!
    
    fileprivate let calendarViewModel = HomeViewModel( withAuthService: FirebaseAuthenticationService(), dbService: FirebaseDBService() )
}
