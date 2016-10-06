//
//  LoginViewController.swift
//  Luna
//
//  Created by Erika Wilcox on 9/23/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController
{
	// MARK: Public API
	//
	
	
	// MARK: Implementation details
	//
	
	private func login( credentials: Credentials )
	{
		// Put network request on background thread.
		//
		DispatchQueue.global( qos: .userInitiated ).async
		{
			do
			{
				let token = try LunaAPI.login( credentials )
				
				
				// Bounce back to main thread to update UI.
				//
				DispatchQueue.main.async
				{
					// TODO: Dismiss this ViewController
					//
					
					// TODO: Present the onboarding ViewController
					//
				}
			}
			catch
			{
				
				// Bounce back to main thread to update UI.
				//
				DispatchQueue.main.async
				{
					// TODO: Show alert or something.
					//
				}
			}
		}
	}
	
    @IBAction private func loginPressed()
	{
		guard let user = usernameTextField.text else { return }
		guard let password = passwordTextField.text else { return }
		
		let credentials = ( user, password )
		login( credentials: credentials )
	}

	@IBOutlet private weak var usernameTextField: UITextField!
	@IBOutlet private weak var passwordTextField: UITextField!
	
	private var loginViewModel = LoginViewModel()
}
