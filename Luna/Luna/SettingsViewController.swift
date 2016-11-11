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
    
}

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "birthCell") as! BirthControlCell
            
            cell.updateCellUI( user: (settingsViewModel.userViewModel?.getUser())! )
            
            return cell
        }
        else if indexPath.row == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "relationshipCell") as! RelationshipStatusCell
            
            cell.updateCellUI( user: (settingsViewModel.userViewModel?.getUser())! )
            
            return cell
        }
        else if indexPath.row == 2
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "disorderCell") as! DisorderCell
            
            cell.updateCellUI( user: (settingsViewModel.userViewModel?.getUser())! )
            
            return cell
        }
        else
        {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    
    
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
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var birthControlCell: BirthControlCell = BirthControlCell()
    fileprivate var disorderCell: DisorderCell = DisorderCell()
    fileprivate var relationshipCell: RelationshipStatusCell = RelationshipStatusCell()
    
	
	fileprivate let settingsViewModel = SettingsViewModel( withAuthService: FirebaseAuthenticationService(), databaseService: FirebaseDBService() )
}
