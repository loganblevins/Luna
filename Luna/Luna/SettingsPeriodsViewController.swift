//
//  SettingsPeriodsViewController.swift
//  Luna
//
//  Created by Erika Wilcox on 11/13/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

class SettingsPeriodsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        //Need to reload the period objects after they have been editted
        loadPeriodsArray()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    func loadPeriodsArray()
    {
        settingsPeriodViewModel.getPeriods()
        {
            errorOrNil in
            
            guard errorOrNil == nil else
            {
                return
            }
            
            //Reload the table after retrieving the period objects from Firebase
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.SettingsStrings.periodCell) as! PeriodCell
        
        if((settingsPeriodViewModel.periods.count) > 0)
        {
            let startDate = settingsPeriodViewModel.periods[indexPath.row].startDate
            let endDate = settingsPeriodViewModel.periods[indexPath.row].endDate
            cell.updateCellUI( date: startDate, endDate: endDate )
        }
        
        return cell        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.selectRow = indexPath.row
        print("the index selected is \(selectRow)")
        performSegue(withIdentifier: Constants.SettingsStrings.toEditPeriod, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let rowCount = settingsPeriodViewModel.periods.count
        return rowCount
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == Constants.SettingsStrings.toEditPeriod
        {
            if let destinationVC = segue.destination as? EditPeriodViewController
            {
                destinationVC.periodVM =  settingsPeriodViewModel.periods[selectRow!]
            }
        }
    }

    var selectRow: Int?
    var periodArray: [PeriodViewModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let settingsPeriodViewModel = SettingsPeriodsViewModel( databaseService: FirebaseDBService() )
    

}
