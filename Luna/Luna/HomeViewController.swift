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
        
        homeViewModel.setDates()
        {
            errorOrNil in
                
            guard errorOrNil == nil else
            {
                return
            }
                
            self.setLabelDates()
        }

    }

	@IBAction fileprivate func addPeriodButtonPressed(_ sender: AnyObject)
    {
        self.MainViewController().presentAddPeriod()
    }
    
    fileprivate func setLabelDates()
    {
        setExpectedPeriodDate( date: homeViewModel.ExpectedPeriodDate )
        setExpectedOvulationDate( date: homeViewModel.ExpectedOvulationDate )
        setDaysUntil()
    }

    fileprivate func setDaysUntil()
    {
        daysUntilLabel.text = "\(homeViewModel.DaysToPeriod)"
    }
    
    fileprivate func setDisplayCurrentDate( date: Date )
    {
        let currentDate = date
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.full
        dateLabel.text = dateFormatter.string(from: currentDate)
        
    }
    
    fileprivate func setExpectedPeriodDate ( date: Date )
    {
        let currentDate = date
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "E, MMM d"
        expectedPeriodLabel.text = dateFormatter.string(from: currentDate)
    }
    
    fileprivate func setExpectedOvulationDate( date: Date )
    {
        let currentDate = date
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "E, MMM d"
        expectedOvuLabel.text = dateFormatter.string(from: currentDate)
    }
    
    
    func MainViewController() -> MainViewController
    {
        return (UIApplication.shared.keyWindow?.rootViewController as? MainViewController)!
    }
    
    
    var window: UIWindow?
    
    @IBOutlet weak var expectedOvuLabel: UILabel!
    @IBOutlet weak var expectedPeriodLabel: UILabel!
    @IBOutlet weak var dailyEntryButton: UIButton!

    @IBOutlet weak var daysUntilLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    fileprivate let homeViewModel = HomeViewModel( withAuthService: FirebaseAuthenticationService(), dbService: FirebaseDBService() )
}
