//
//  MainViewController.swift
//  Luna
//
//  Created by Logan Blevins on 10/5/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

protocol SettingsDelegate: class
{
    func editBirthControlInfo()
    func editRelationshipStatus()
    func editDisorderInfo()
}

protocol AddPeriodDelegate: class
{
    func presentAddPeriod()
    func onDismissAddPeriod()
    func onLastCycleChange()
}

final class MainViewController: UITabBarController, LoginCompletionDelegate, OnBoardCompletionDelegate, AddPeriodDelegate
{
	fileprivate(set) var onboardingActive = false
	fileprivate(set) var loginActive = false
	
	func onLoginSuccess()
	{
		print( "onLoginSuccess" )
		loginViewController?.dismiss( animated: true )
		{
			self.loginActive = false
		}
	}

    func checkOnBoardStatus()
    {
        mainViewModel.checkOnBoardStatus()
        {
            [weak self] error, status in
			guard let strongSelf = self else { return }
			guard let status = status else { return }
			
            if !status
            {
                strongSelf.presentOnBoard()
            }
            else
            {
                self?.HomeViewController().onOnboardComplete()
            }
        }
    }
    
    func onLastCycleChange()
    {
        self.HomeViewController().onLastCycleChange()
    }
    
	func maybePresentLogin()
	{
		if !loginActive
		{
			loginActive = true
			loginViewController = LoginViewController.storyboardInstance()
			loginViewController!.delegate = self
			present( loginViewController!, animated: true, completion: nil )
		}
	}
	
	func HomeViewController() -> HomeViewController
	{
		return self.viewControllers![0] as! HomeViewController
	}
	
	func CalendarViewController() -> CalendarViewController
	{
		return self.viewControllers![1] as! CalendarViewController
	}
	
	func SettingsViewController() -> SettingsViewController
	{
        return self.viewControllers![2] as! SettingsViewController
	}
	
    func presentOnBoard()
    {
		pageViewController = OBPageViewController.storyboardInstance()
		pageViewController?.onboardCompletionDelegate = self
		onboardingActive = true
		guard let strongVC = pageViewController else { return }
		present( strongVC, animated: true, completion: nil )
    }
	
    func onOnboardComplete()
    {
        pageViewController?.dismiss( animated: true )
		{
			self.onboardingActive = false
		}
        mainViewModel.setOnBoardStatus( status: true )
        HomeViewController().onOnboardComplete()
    }
	
    func presentAddPeriod()
    {
        addPeriodViewController = AddPeriodViewController.storyboardInstance()
        addPeriodViewController?.delegate = self
        present( addPeriodViewController!, animated: true, completion: nil )
    }
    
    func onDismissAddPeriod()
    {
        addPeriodViewController?.dismiss( animated: true, completion: nil )
    }

    
	fileprivate var loginViewController: LoginViewController?
    fileprivate var addPeriodViewController: AddPeriodViewController?
	fileprivate var pageViewController: OBPageViewController?
    fileprivate let mainViewModel = MainViewModel( withAuthService: FirebaseAuthenticationService(), dbService: FirebaseDBService() )
}


