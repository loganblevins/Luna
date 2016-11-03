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

		showNetworkActivity( show: true )
		loginViewModel.loginAsync( credentials )
		{
			error in
			guard error != nil else { return }
			
			DispatchQueue.main.async
			{
				switch error
				{
				case is LunaAPIError:
					let e = error as! LunaAPIError
					print( e.description )
					let alertController = UIAlertController( title: e.description, message: nil, preferredStyle: .alert )
					alertController.addAction( UIAlertAction( title: "Ok", style: .default, handler: nil ) )
					self.present( alertController, animated: true, completion: nil )
					
				case is NetworkError:
					let e = error as! NetworkError
					print( e.description )
					let alertController = UIAlertController( title: e.description, message: nil, preferredStyle: .alert )
					alertController.addAction( UIAlertAction( title: "Ok", style: .default, handler: nil ) )
					self.present( alertController, animated: true, completion: nil )
					
				default:
					print( error?.localizedDescription ?? "Unknown login error." )
					let alertController = UIAlertController( title: error?.localizedDescription, message: nil, preferredStyle: .alert )
					alertController.addAction( UIAlertAction( title: "Ok", style: .default, handler: nil ) )
					self.present( alertController, animated: true, completion: nil )
				}
				
				defer
				{
					showNetworkActivity( show: false )
				}
			}
		}
	}

	@IBOutlet fileprivate weak var usernameTextField: UITextField!
	@IBOutlet fileprivate weak var passwordTextField: UITextField!
	
	fileprivate let loginViewModel = LoginViewModel( withAuthService: FirebaseAuthenticationService(), databaseService: FirebaseDBService() )
}
