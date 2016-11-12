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
	
	override init()
	{
		super.init()
		
		// This is dumb. But...it fixes the database connection crashes. 
		//
		FIRApp.configure()
		FIRDatabase.database().persistenceEnabled = true
	}
	
	// MARK: App Delegate callbacks
	//
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey:Any]? ) -> Bool
    {
		Fabric.with( [Crashlytics.self] )
		
		signInUser()
		
		return true
	}
	
	func applicationWillTerminate(_ application: UIApplication )
	{
		FirebaseAuthenticationService.RemoveAuthChangeListener( self.authChangeHandle )
	}
	
	// MARK: Implmentation Details
	//
	
	fileprivate func signInUser()
	{
		// Check if we have a pre-existing user.
		// 
		// If so, do nothing.
		// If not, present login VC -> present onboarding.
		//
		self.authChangeHandle = FirebaseAuthenticationService.AuthChangeListener()
		{
			[weak self] user in
			guard let strongSelf = self else { return }
			
			if user == nil
			{
				strongSelf.MainViewController().presentLogin()
			}
            else
            {
                if(self?.runningOnBoard == false)
                {
                    self?.runningOnBoard = true
                    strongSelf.MainViewController().checkOnBoardStatus()
                }
                
            }
            
		}
	}
		
	fileprivate func MainViewController() -> MainViewController
	{
		return ( window!.rootViewController as! MainViewController )
	}
	
    fileprivate var runningOnBoard: Bool = false
	fileprivate var authChangeHandle: FIRAuthStateDidChangeListenerHandle!
}
