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
	// TODO: I really hate this. It's bad design and somewhat fragile. 
	// Either I need this class to own the instance of LoginViewController, or 
	// I need to use a different method of dismissing the login screen, rather than delegation.
	//
	func onLoginSuccess()
	{
		if presentedViewController != nil && presentedViewController is LoginViewController
		{
			presentedViewController?.dismiss( animated: true, completion: nil )
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
}
