//
//  SettingsViewController.swift
//  Luna
//
//  Created by Logan Blevins on 11/3/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
		
		navBarTopItem.title = "Settings"
        tableView.delegate = self
        tableView.dataSource = self
        
        settingsViewModel.getUserData()
        {
           errorOrNil in

            guard errorOrNil == nil else
            {
                return
            }
            
            self.tableView.reloadData()
        }
        
        settingsViewModel.getPeriods()
        {
            errorOrNil in
                
            guard errorOrNil == nil else
            {
                return
            }
        }
        
    }
    
    weak var delegate: SettingsDelegate?
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.SettingsStrings.settingsCell) as! SettingsCell
        
        if(settingsViewModel.userViewModel != nil)
        {
            if indexPath.row == 0
            {
                cell.updateCellUI(title: Constants.SettingsStrings.BirthCtrl, value: (settingsViewModel.userViewModel?.birthControl)!)
            }
            else if indexPath.row == 1
            {
                cell.updateCellUI(title: Constants.SettingsStrings.Relationship, value: (settingsViewModel.userViewModel?.relationshipStatus)!)
            }
            else if indexPath.row == 2
            {
                cell.updateCellUI(title: Constants.SettingsStrings.Disorder, value: (settingsViewModel.userViewModel?.disorder)!)
            }
            else if indexPath.row == 3
            {
                cell.updateCellUI(title: Constants.SettingsStrings.Periods, value: "")
            }
            else
            {
                cell.updateCellUI(title: "", value: "")
            }
        }
        else
        {
            if indexPath.row == 0
            {
                cell.updateCellUI(title: Constants.SettingsStrings.BirthCtrl, value: "")
            }
            else if indexPath.row == 1
            {
                cell.updateCellUI(title: Constants.SettingsStrings.Relationship, value: "")
            }
            else if indexPath.row == 2
            {
                cell.updateCellUI(title: Constants.SettingsStrings.Disorder, value: "")
            }
            else if indexPath.row == 3
            {
                cell.updateCellUI(title: Constants.SettingsStrings.Periods, value: "")
            }
            else
            {
                cell.updateCellUI(title: "", value: "")
            }
        }
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let selectedRow = indexPath.row
        print("the index selected is \(selectedRow)")
        
        handleRowSelection( row: selectedRow )
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 4
    }
    
    fileprivate func handleRowSelection( row: Int )
    {
        switch row
        {
        case 0:
            performSegue(withIdentifier: Constants.SettingsStrings.toEditBirth, sender: nil)
            //self.delegate?.editBirthControlInfo()
            break
        case 1:
            performSegue(withIdentifier: Constants.SettingsStrings.toEditRelationship, sender: nil)
            //self.delegate?.editRelationshipStatus()
            break
        case 2:
            performSegue(withIdentifier: Constants.SettingsStrings.toEditDisorder, sender: nil)
            //self.delegate?.editDisorderInfo()
            break
        case 3:
            //performSegue( withIdentifier: Constants.SettingsStrings.toPeriods, sender: nil )
            break
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == Constants.SettingsStrings.toEditBirth
        {
            if let destinationVC = segue.destination as? SettingsBirthControlViewController
            {
                destinationVC.valuePassed = (settingsViewModel.userViewModel?.birthControl)!
            }
        }
        if segue.identifier == Constants.SettingsStrings.toEditRelationship
        {
            if let destinationVC = segue.destination as? SettingsRelationshipViewController
            {
                destinationVC.valuePassed = (settingsViewModel.userViewModel?.relationshipStatus)!
            }
        }
        if segue.identifier == Constants.SettingsStrings.toPeriods
        {
            if let destinationVC = segue.destination as? SettingsPeriodsViewController
            {
                destinationVC.periodArrayRecieved = settingsViewModel.periods
            }
        }

    }
    
	fileprivate var navBarTopItem: UINavigationItem!
	{
		return self.navigationController?.navigationBar.topItem
	}
	
    @IBOutlet weak var tableView: UITableView!
    
	fileprivate let settingsViewModel = SettingsViewModel( withAuthService: FirebaseAuthenticationService(), databaseService: FirebaseDBService() )
}
