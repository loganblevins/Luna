//
//  SettingsViewController.swift
//  Luna
//
//  Created by Logan Blevins on 11/3/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit


protocol SettingsDelegate: class
{
    
    func editBirthControlInfo()
    
    func editRelationshipStatus()
    
    func editDisorderInfo()
}

extension SettingsDelegate
{
    
    func editBirthControlInfo()
    {
        
    }
    
    func editRelationshipStatus()
    {
        
    }
    
    func editDisorderInfo()
    {
        
    }
}

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //settingsViewModel.getUserData()
        //{
        //    errorOrNil in

        //    guard errorOrNil == nil else
        //    {
        //        return
        //    }
        //}
        
    }
    
	@IBAction func logoutButtonPressed()
	{
		let alert = UIAlertController( title: Constants.InterfaceBuilderStrings.confirmTitle,
		                               message: nil,
		                               preferredStyle: .alert )
		alert.addAction( .init( title: Constants.InterfaceBuilderStrings.yesButtonTitle, style: .destructive ) { _ in self.logoutUser() } )
		alert.addAction( .init( title: Constants.InterfaceBuilderStrings.cancelButtonTitle, style: .cancel, handler: nil ) )
		present( alert, animated: true, completion: nil )
	}
	
	@IBAction func deleteAccountButtonPressed()
	{
		let alert = UIAlertController( title: Constants.InterfaceBuilderStrings.confirmTitle,
		                               message: Constants.InterfaceBuilderStrings.deleteUserConfirmMessage,
		                               preferredStyle: .alert )
		alert.addAction( .init( title: Constants.InterfaceBuilderStrings.yesButtonTitle, style: .destructive ) { _ in self.deleteAccount() } )
		alert.addAction( .init( title: Constants.InterfaceBuilderStrings.cancelButtonTitle, style: .cancel, handler: nil ) )
		present( alert, animated: true, completion: nil )
	}
	
	fileprivate func logoutUser()
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
	
	fileprivate func deleteAccount()
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
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.row == 0
        {
            //let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell") as! SettingsCell
            
            //cell.updateCellUI( user: (settingsViewModel.userViewModel?.getUser())! )
            
            //cell.clipsToBounds = true
            
            //return cell
            return UITableViewCell()
        }
        else if indexPath.row == 1
        {
           // let cell = tableView.dequeueReusableCell(withIdentifier: "relationshipCell") as! RelationshipStatusCell
            
            //cell.updateCellUI( user: (settingsViewModel.userViewModel?.getUser())! )
            
            //cell.clipsToBounds = true
            return UITableViewCell()
            
            //return cell
        }
        else if indexPath.row == 2
        {
           // let cell = tableView.dequeueReusableCell(withIdentifier: "disorderCell") as! DisorderCell
            
            //cell.updateCellUI( user: (settingsViewModel.userViewModel?.getUser())! )
            
            //cell.clipsToBounds = true
            
            //return cell
            return UITableViewCell()
        }
        else
        {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    
    @IBOutlet weak var tableView: UITableView!
    
	fileprivate let settingsViewModel = SettingsViewModel( withAuthService: FirebaseAuthenticationService(), databaseService: FirebaseDBService() )
}
