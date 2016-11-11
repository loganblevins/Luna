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
			
			// TODO: Does anyone need to know about completion of this??
			//
		}
		catch
		{
			print( error.localizedDescription )
		}
	}
	
	@IBAction func deleteAccountButtonPressed()
	{
		showNetworkActivity( show: true )
		settingsViewModel.deleteAccountAsync()
		{
			[weak self] error in
			guard let strongSelf = self else { return }
			
			defer
			{
				DispatchQueue.main.async
				{
					showNetworkActivity( show: false )
				}
			}
			
			guard error == nil else
			{
				DispatchQueue.main.async
				{
					strongSelf.handleDeleteAccountError( error! )
				}
				return
			}
			
			// TODO: Does anyone need to know about completion of this??
			//
		}
	}
	
	fileprivate func handleDeleteAccountError(_ error: Error )
	{
		switch error
		{
		case is ServiceAuthenticatableError:
			let e = error as! ServiceAuthenticatableError
			print( e.description )
			
		case is LunaAPIError:
			let e = error as! LunaAPIError
			print( e.description )
			
		case is NetworkError:
			let e = error as! NetworkError
			print( e.description )
		
		default:
			print( error.localizedDescription )
		}
	}
	
	fileprivate let settingsViewModel = SettingsViewModel( withAuthService: FirebaseAuthenticationService(), databaseService: FirebaseDBService() )
}
