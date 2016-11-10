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
    
    func startOnBoard()
    {
        //NEED TO ADD CHECK IF THEY HAVE ALREADY ONBOARDED
        toAddImageView()
    }
    
    func onBoardComplete()
    {
        relationshipViewController?.dismiss( animated: true, completion: nil )
    }
    
    func checkOnBoardStatus()
    {
        
    }
    
	func presentLogin()
	{
		loginViewController = LoginViewController.storyboardInstance()
		loginViewController!.delegate = self
		//rootPresent( self.view, controller: loginViewController! )
        
        present( loginViewController!, animated:  true, completion: nil )
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
    
    func toAddImageView()
    {
        addImageViewController = OBAddImageViewController.storyboardInstance()
        addImageViewController!.delegate = self
        
        present( addImageViewController!, animated: true, completion: nil )
    }
    
    
    func toBirthControlView()
    {
        addImageViewController?.dismiss( animated: true, completion: nil )
        
        birthControlViewController = OBBirthControlViewController.storyboardInstance()
        birthControlViewController!.delegate = self
        //rootPresent( self.view , controller: birthControlViewController! )
        present( birthControlViewController!, animated: true, completion: nil )
    }
    
    func toMenstrualLenView()
    {
        birthControlViewController?.dismiss( animated: true, completion: nil )
        
        menstrualLenViewcontroller = OBMenstrualLenViewController.storyboardInstance()
        menstrualLenViewcontroller!.delegate = self
        //rootPresent( self.view, controller: menstrualLenViewcontroller! )
        
        present( menstrualLenViewcontroller!, animated: true, completion: nil )
    }
    
    func toLastCycleView()
    {
        menstrualLenViewcontroller?.dismiss( animated: true, completion: nil )
        
        lastCycleViewController = OBLastCycleViewController.storyboardInstance()
        lastCycleViewController?.delegate = self
        //rootPresent( self.view, controller: lastCycleViewController! )
        
        present( lastCycleViewController!, animated: true, completion: nil )
    }
    
    func toDisorderView()
    {
        
        lastCycleViewController?.dismiss( animated: true, completion: nil )
        
        disorderViewController = OBDisorderViewController.storyboardInstance()
        disorderViewController?.delegate = self
        //rootPresent( self.view, controller: disorderViewController! )
        
        present( disorderViewController!, animated: true, completion: nil )
    }
    
    func toRelationshipView()
    {
        disorderViewController?.dismiss( animated: true, completion: nil )
        
        relationshipViewController = OBRelationshipViewController.storyboardInstance()
        relationshipViewController?.delegate = self
        //rootPresent( self.view , controller: relationshipViewController! )
        
        present( relationshipViewController!, animated: true, completion: nil )
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
    func checkOnBoardStatus()
    
    func onBoardComplete()
    
    func toBirthControlView()
    
    func toRelationshipView()
    
    func toMenstrualLenView()
    
    func toLastCycleView()
    
    func toDisorderView()
}
