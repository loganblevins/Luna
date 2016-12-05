//
//  LoginViewController.swift
//  Luna
//
//  Created by Erika Wilcox on 9/23/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

protocol LoginCompletionDelegate: class
{
	func onLoginSuccess()
}

class LoginViewController: UIViewController, UITextFieldDelegate
{
	// MARK: Public API
	//
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		usernameTextField.delegate = self
		passwordTextField.delegate = self
	}
	
	static func storyboardInstance() -> LoginViewController?
	{
		let storyboard = UIStoryboard( name: String( describing: self ), bundle: nil )
		return storyboard.instantiateInitialViewController() as? LoginViewController
	}

	func textFieldShouldReturn(_ textField: UITextField ) -> Bool
	{
		textField.resignFirstResponder()
		return true
	}
	
	weak var delegate: LoginCompletionDelegate?
	
	// MARK: Implementation details
	//
	
    @IBAction fileprivate func loginPressed()
	{
		signInUser()
	}

	fileprivate func signInUser()
	{
		guard let user = usernameTextField.text else { return }
		guard let password = passwordTextField.text else { return }
		let credentials = ( user, password )
		
		showNetworkActivity( show: true )
		loginViewModel.loginAsync( credentials )
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
				// Update UI according to error on main thread.
				//
				DispatchQueue.main.async
                {
						strongSelf.handleLoginError( error! )
				}
				return
			}
			
			strongSelf.delegate?.onLoginSuccess()
		}
	}
	
	fileprivate func handleLoginError(_ error: Error )
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
			print( error.localizedDescription )
		}
	}
	
	@IBOutlet fileprivate weak var usernameTextField: UITextField!
	@IBOutlet fileprivate weak var passwordTextField: UITextField!
	
	fileprivate let loginViewModel = LoginViewModel( withAuthService: FirebaseAuthenticationService(), dbService: FirebaseDBService() )
}
