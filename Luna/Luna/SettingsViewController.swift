//
//  SettingsViewController.swift
//  Luna
//
//  Created by Logan Blevins on 11/3/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController
{
	
	@IBAction func logoutButtonPressed()
	{
		do
		{
			try settingsViewModel.logout()
		}
		catch
		{
			print( error.localizedDescription )
		}
	}
	
	fileprivate let settingsViewModel = SettingsViewModel( withAuthService: FirebaseAuthenticationService(), databaseService: FirebaseDBService() )
}
