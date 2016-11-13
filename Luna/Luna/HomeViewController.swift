//
//  HomeViewController.swift
//  Luna
//
//  Created by Logan Blevins on 11/3/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setDisplayCurrentDate( date: Date() )
    }
    
	@IBAction fileprivate func enterDataButtonPressed(_ sender: AnyObject)
    {
        performSegue(withIdentifier: Constants.HomeStrings.toEntry, sender: nil)
    }
    
    @IBAction func nextDayPressed(_ sender: Any)
    {
        setNextDate()
    }
    
    @IBAction func previousDayPressed(_ sender: Any)
    {
        setPreviousDate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {

        if let destinationVC = segue.destination as? DailyEntryViewController
        {
            destinationVC.valuePassed = homeViewModel.returnCurrentDate()
        }
    }
    
    //This gunction compares todays date to the current date and decides whether or not
    // to enable the next day button. It should be disabled if the date is Today to prevent
    // the user from entering future data
    fileprivate func shouldHideFutureDateButton()
    {
        let today = NSDate()
        let currentDate = homeViewModel.returnCurrentDate()

        let order = Calendar.current.compare(today as Date, to: currentDate, toGranularity: .day)
        
        switch order
        {
        case .orderedSame:
            print("todays date, disable next button")
            nextDateButton.isEnabled = false
        default:
            nextDateButton.isEnabled = true
        }

    }
    
    fileprivate func setNextDate()
    {
        let date = homeViewModel.returnCurrentDate()
        
        let daysToAdd:Int = 1
        
        // Set up date components
        let dateComponents: NSDateComponents = NSDateComponents()
        dateComponents.day = daysToAdd
        
        // Create a calendar
        let gregorianCalendar: NSCalendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!
        let yesterDayDate: NSDate = gregorianCalendar.date(byAdding: dateComponents as DateComponents, to: date, options:NSCalendar.Options(rawValue: 0))! as NSDate
        
        setDisplayCurrentDate( date: yesterDayDate as Date )
    }
    
    fileprivate func setPreviousDate()
    {
        let date = homeViewModel.returnCurrentDate()

        let daysToAdd:Int = -1
        
        // Set up date components
        let dateComponents: NSDateComponents = NSDateComponents()
        dateComponents.day = daysToAdd
        
        // Create a calendar
        let gregorianCalendar: NSCalendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!
        let yesterDayDate: NSDate = gregorianCalendar.date(byAdding: dateComponents as DateComponents, to: date, options:NSCalendar.Options(rawValue: 0))! as NSDate

        setDisplayCurrentDate( date: yesterDayDate as Date )
    }
    
    fileprivate func setDisplayCurrentDate( date: Date )
    {
        let currentDate = date
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.long
        dateLabel.text = dateFormatter.string(from: currentDate)
        
        updateDate( newDate: currentDate )
    }
    
    fileprivate func updateDate( newDate: Date )
    {
        homeViewModel.setCurrentDate( date: newDate )
        shouldHideFutureDateButton()
    }

    @IBOutlet weak var nextDateButton: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    fileprivate let homeViewModel = HomeViewModel( withAuthService: FirebaseAuthenticationService(), dbService: FirebaseDBService() )
}
