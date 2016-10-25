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
			let lunaAPI = LunaAPI( requestor: LunaRequestor() )
			lunaAPI.login( credentials )
			{
				token in
				
				
			}
		}
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
