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
		FIRDatabase.database().persistenceEnabled = false
	}
	
	// MARK: App Delegate callbacks
	//
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey:Any]? ) -> Bool
    {
		Fabric.with( [Crashlytics.self] )
		
		maybeSignOutUser()
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
				strongSelf.MainViewController().maybePresentLogin()
			}
            else
            {
				print( "Have a user" )
				strongSelf.persist( uid: user!.uid )
				strongSelf.maybeCheckOnboardStatus()
            }
		}
	}
	
	fileprivate func maybeSignOutUser()
	{
		let authService: ServiceAuthenticatable = FirebaseAuthenticationService()
		if StandardDefaults.sharedInstance.initialInstall
		{
			print( "Initial install." )
			try? authService.signOutUser()
			StandardDefaults.sharedInstance.initialInstall = false
		}
	}
	
	fileprivate func maybeCheckOnboardStatus()
	{
		if !self.MainViewController().onboardingActive
		{
			self.MainViewController().checkOnBoardStatus()
		}
	}
	
	fileprivate func persist( uid: String )
	{
		StandardDefaults.sharedInstance.uid = uid
	}
	
	fileprivate func MainViewController() -> MainViewController
	{
		return ( window!.rootViewController as! MainViewController )
	}
	
	fileprivate var authChangeHandle: FIRAuthStateDidChangeListenerHandle!
}
