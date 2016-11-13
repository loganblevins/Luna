//
//  MainViewController.swift
//  Luna
//
//  Created by Logan Blevins on 10/5/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

protocol OnBoardDelegate: class
{
	func onBoardComplete()
	func toBirthControlView()
	func toRelationshipView()
	func toMenstrualLenView()
	func toLastCycleView()
	func toDisorderView()
}

final class MainViewController: UITabBarController, LoginCompletionDelegate, OnBoardDelegate, SettingsDelegate
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
			
            if !status!
            {
                strongSelf.presentOnBoard()
            }
        }
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
        addImageViewController = OBAddImageViewController.storyboardInstance()
        addImageViewController!.delegate = self
		onboardingActive = true
        present ( addImageViewController!, animated: true, completion: nil )
    }
    
    func toBirthControlView()
    {
        addImageViewController?.dismiss( animated: true, completion: nil )
        
        birthControlViewController = OBBirthControlViewController.storyboardInstance()
        birthControlViewController!.delegate = self
        present ( birthControlViewController!, animated: true, completion: nil)
    }
    
    func toMenstrualLenView()
    {
        birthControlViewController?.dismiss( animated: true, completion: nil )
        
        menstrualLenViewcontroller = OBMenstrualLenViewController.storyboardInstance()
        menstrualLenViewcontroller!.delegate = self
        present ( menstrualLenViewcontroller!, animated: true, completion: nil)
    }
    
    func toLastCycleView()
    {
        menstrualLenViewcontroller?.dismiss( animated: true, completion: nil )
        
        lastCycleViewController = OBLastCycleViewController.storyboardInstance()
        lastCycleViewController?.delegate = self
        present ( lastCycleViewController!, animated: true, completion: nil)
    }
    
    func toDisorderView()
    {
        lastCycleViewController?.dismiss( animated: true, completion: nil )
        
        disorderViewController = OBDisorderViewController.storyboardInstance()
        disorderViewController?.delegate = self
        present ( disorderViewController!, animated: true, completion: nil)
    }
    
    func toRelationshipView()
    {
        disorderViewController?.dismiss( animated: true, completion: nil )
        
        relationshipViewController = OBRelationshipViewController.storyboardInstance()
        relationshipViewController?.delegate = self
        present ( relationshipViewController!, animated: true, completion: nil )
    }
    
    func onBoardComplete()
    {
        relationshipViewController?.dismiss( animated: true )
		{
			self.onboardingActive = false
		}
		
        mainViewModel.setOnBoardStatus( status: true )
    }
    
    func editBirthControlInfo()
    {
        editBirthControlViewController = SettingsBirthControlViewController.storyboardInstance()
        editBirthControlViewController!.delegate = self
        present ( editBirthControlViewController!, animated: true, completion: nil)
    }
    
    func editRelationshipStatus()
    {
        editRelationshipViewController = SettingsRelationshipViewController.storyboardInstance()
        editRelationshipViewController!.delegate = self
        present ( editRelationshipViewController!, animated: true, completion: nil)
    }
    
    func editDisorderInfo()
    {
        editDisorderViewController = SettingsDisorderViewController.storyboardInstance()
        editDisorderViewController!.delegate = self
        present ( editDisorderViewController!, animated: true, completion: nil)
    }
    
    func dismissEditBirthControl()
    {
        editBirthControlViewController?.dismiss( animated: true, completion: nil )
    }
    
    func dismissEditRelationship()
    {
        editRelationshipViewController?.dismiss( animated: true, completion: nil )
    }
    
    func dismissEditDisorder()
    {
        editDisorderViewController?.dismiss( animated: true, completion: nil )
    }
    
	fileprivate var loginViewController: LoginViewController?
    
    fileprivate var addImageViewController: OBAddImageViewController?
    fileprivate var birthControlViewController: OBBirthControlViewController?
    fileprivate var menstrualLenViewcontroller: OBMenstrualLenViewController?
    fileprivate var lastCycleViewController: OBLastCycleViewController?
    fileprivate var relationshipViewController: OBRelationshipViewController?
    fileprivate var disorderViewController: OBDisorderViewController?

    
    fileprivate var editBirthControlViewController: SettingsBirthControlViewController?
    fileprivate var editRelationshipViewController: SettingsRelationshipViewController?
    fileprivate var editDisorderViewController: SettingsDisorderViewController?
    
    fileprivate let mainViewModel = MainViewModel( withAuthService: FirebaseAuthenticationService(), dbService: FirebaseDBService() )
}

protocol EditSettingsDelegate: class
{
   
    func dismissEditBirthControl()
    func dismissEditRelationship()
    func dismissEditDisorder()
}

protocol SettingsDelegate: class
{
    func editBirthControlInfo()
    func editRelationshipStatus()
    func editDisorderInfo()
}
