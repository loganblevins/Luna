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
        
        periodArray = periodArrayRecieved

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.SettingsStrings.periodCell) as! PeriodCell
        
        if((periodArray?.count)! > 0)
        {
            let startDate = periodArray?[indexPath.row].startDate
            let endDate = periodArray?[indexPath.row].endDate
            cell.updateCellUI( date: startDate!, endDate: endDate! )
        }
        
        return cell        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.selectRow = indexPath.row
        print("the index selected is \(selectRow)")
        //performSegue(withIdentifier: Constants.SettingsStrings.toEditPeriod, sender: nil)
    }
    
    fileprivate func handleRowSelection( row: Int )
    {
            }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == Constants.SettingsStrings.toEditPeriod
        {
            if let destinationVC = segue.destination as? EditPeriodViewController
            {
                destinationVC.periodVM =  periodArray?[selectRow!]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let rowCount = periodArray?.count ?? 0
        return rowCount
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    var selectRow: Int?
    var periodArrayRecieved: [PeriodViewModel] = []
    var periodArray: [PeriodViewModel]?
    @IBOutlet weak var tableView: UITableView!
    

}
