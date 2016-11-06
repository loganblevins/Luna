//
//  MainViewController.swift
//  Luna
//
//  Created by Logan Blevins on 10/5/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

final class MainViewController: UITabBarController, LoginCompletionDelegate
{
	func onLoginSuccess()
	{
		loginViewController?.dismiss( animated: true, completion: nil )
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
	
	fileprivate var loginViewController: LoginViewController?
}
