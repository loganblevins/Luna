//
//  AppDelegate.swift
//  Luna
//
//  Created by Logan Blevins on 9/13/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey:Any]? ) -> Bool
    {
		Fabric.with( [ Crashlytics.self ] )
		FIRApp.configure()
		
		signInUser()
		
		return true
	}
	
	fileprivate func signInUser()
	{
		// TODO: Check if we have a pre-existing valid token.
		// 
		// If so, continue on.
		// If not, present login VC.
		//
	}
}
