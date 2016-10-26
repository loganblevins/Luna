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
	
	private func login(_ credentials: Credentials )
	{
		// Put network request on background thread.
		//
		DispatchQueue.global( qos: .userInitiated ).async
		{
			DispatchQueue.main.async
			{
				showNetworkActivity( show: true )
			}
			
			let lunaAPI = LunaAPI( requestor: LunaRequestor() )
			lunaAPI.login( credentials )
			{
				innerThrows in
				do
				{
					try innerThrows()
				}
				catch LunaAPIError.BlankUsername
				{
					
				}
				catch LunaAPIError.BlankPassword
				{
					
				}
				catch
				{
					// Must be NetworkError
				}
			}
			
			defer
			{
				DispatchQueue.main.async
				{
					showNetworkActivity( show: false )
				}
			}
		}
	}
	
	fileprivate func onLoggedIn(_ token: FirebaseToken )
	{
		
	}
	
    @IBAction private func loginPressed()
	{
		guard let user = usernameTextField.text else { return }
		guard let password = passwordTextField.text else { return }
		
		let credentials = ( user, password )
		login( credentials )
	}

	@IBOutlet private weak var usernameTextField: UITextField!
	@IBOutlet private weak var passwordTextField: UITextField!
	
	private var loginViewModel = LoginViewModel()
}
