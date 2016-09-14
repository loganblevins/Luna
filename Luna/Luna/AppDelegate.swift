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
	
	func application( _ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [ UIApplicationLaunchOptionsKey : Any ]? ) -> Bool
    {
		Fabric.with( [ Crashlytics.self ] )
		FIRApp.configure()
		return true
	}
}
