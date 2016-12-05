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
    
    func onLastCycleChange()
    {
        homeViewModel.upDateView()
        setLabelDates()
    }
    
    func onOnboardComplete()
    {
     
        setDisplayCurrentDate( date: Date() )
        
        guard StandardDefaults.sharedInstance.uid != nil else
        {
            assertionFailure( "StandardDefaults returned bad uid." )
            return
        }
       
        homeViewModel.setDates()
        
        setLabelDates()
	}

	@IBAction fileprivate func addPeriodButtonPressed(_ sender: AnyObject)
    {
        self.MainViewController().presentAddPeriod()
    }
    
    fileprivate func setLabelDates()
    {
        formatDate(label: expectedOvuLabel, date: homeViewModel.ExpectedOvulationDate)
        formatDate(label: expectedPeriodLabel, date: homeViewModel.ExpectedPeriodDate)
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
    
    fileprivate func formatDate( label: UILabel, date: Date )
    {
        let currentDate = date
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "E, MMM d"
        label.text = dateFormatter.string(from: currentDate)
    }
    
    
    func MainViewController() -> MainViewController
    {
        return (UIApplication.shared.keyWindow?.rootViewController as? MainViewController)!
    }
    

    @IBOutlet weak var expectedOvuLabel: UILabel!
    @IBOutlet weak var expectedPeriodLabel: UILabel!
    @IBOutlet weak var dailyEntryButton: UIButton!
    @IBOutlet weak var daysUntilLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    fileprivate let homeViewModel = HomeViewModel( withAuthService: FirebaseAuthenticationService(), dbService: FirebaseDBService() )
}
