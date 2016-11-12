//
//  MainViewController.swift
//  Luna
//
//  Created by Logan Blevins on 10/5/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit


final class MainViewController: UITabBarController, LoginCompletionDelegate, OnBoardDelegate
{
	func onLoginSuccess()
	{
		loginViewController?.dismiss( animated: true, completion: nil )
        
        startOnBoard()
	}
    
    func onBoardComplete()
    {
        disorderViewController?.dismiss( animated: true, completion: nil )
    }
    
    
	func presentLogin()
	{
		loginViewController = LoginViewController.storyboardInstance()
		loginViewController!.delegate = self
		rootPresent( self.view, controller: loginViewController! )
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
    
    func startOnBoard()
    {
        addImageViewController = OBAddImageViewController.storyboardInstance()
        addImageViewController!.delegate = self
        rootPresent( self.view , controller: addImageViewController! )
    }
    
    func toBirthControlView()
    {
        addImageViewController?.dismiss( animated: true, completion: nil )
        
        birthControlViewController = OBBirthControlViewController.storyboardInstance()
        birthControlViewController!.delegate = self
        rootPresent( self.view , controller: birthControlViewController! )
    }
    
    func toMenstrualLenView()
    {
        birthControlViewController?.dismiss( animated: true, completion: nil )
        
        menstrualLenViewcontroller = OBMenstrualLenViewController.storyboardInstance()
        menstrualLenViewcontroller!.delegate = self
        rootPresent( self.view, controller: menstrualLenViewcontroller! )
    }
    
    func toLastCycleView()
    {
        menstrualLenViewcontroller?.dismiss( animated: true, completion: nil )
        
        lastCycleViewController = OBLastCycleViewController.storyboardInstance()
        lastCycleViewController?.delegate = self
        rootPresent( self.view, controller: lastCycleViewController! )
    }
    
    func toRelationshipView()
    {
        lastCycleViewController?.dismiss( animated: true, completion: nil )
        
        relationshipViewController = OBRelationshipViewController.storyboardInstance()
        relationshipViewController?.delegate = self
        rootPresent( self.view , controller: relationshipViewController! )
    }
    
    func toDisorderView()
    {
        relationshipViewController?.dismiss( animated: true, completion: nil )
        
        disorderViewController = OBDisorderViewController.storyboardInstance()
        disorderViewController?.delegate = self
        rootPresent( self.view, controller: disorderViewController! )
    }
    
    
	fileprivate var loginViewController: LoginViewController?
    
    fileprivate var addImageViewController: OBAddImageViewController?
    fileprivate var birthControlViewController: OBBirthControlViewController?
    fileprivate var menstrualLenViewcontroller: OBMenstrualLenViewController?
    fileprivate var lastCycleViewController: OBLastCycleViewController?
    fileprivate var relationshipViewController: OBRelationshipViewController?
    fileprivate var disorderViewController: OBDisorderViewController?
}


protocol OnBoardDelegate: class
{
    func onBoardComplete()
    
    func toBirthControlView()
    
    func toRelationshipView()
    
    func toMenstrualLenView()
    
    func toLastCycleView()
    
    func toDisorderView()
    
}
