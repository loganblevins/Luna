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
	
	static func storyboardInstance() -> LoginViewController?
	{
		let storyboard = UIStoryboard( name: String( describing: self ), bundle: nil )
		return storyboard.instantiateInitialViewController() as? LoginViewController
	}

	// MARK: Implementation details
	//
	
    @IBAction fileprivate func loginPressed()
	{
		guard let user = usernameTextField.text else { return }
		guard let password = passwordTextField.text else { return }
		
		let credentials = ( user, password )
		loginViewModel.loginAsync( credentials )
		{
			error in
			
			DispatchQueue.main.async
			{
				switch error
				{
				case is LunaAPIError:
					let e = error as! LunaAPIError
					print( e.description )
					
				case is NetworkError:
					let e = error as! NetworkError
					print( e.description )
					
				default:
					print( error?.localizedDescription ?? "Unknown login error." )
				}
			}
		}
	}

	@IBOutlet fileprivate weak var usernameTextField: UITextField!
	@IBOutlet fileprivate weak var passwordTextField: UITextField!
	
	fileprivate var loginViewModel = LoginViewModel( withAuthService: FirebaseAuthenticationService(), databaseService: FirebaseDBService() )
}
