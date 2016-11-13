//
//  DailyEntryViewController.swift
//  Luna
//
//  Created by Erika Wilcox on 11/12/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit


protocol AddPeriodDelegate: class
{
    func presentAddPeriod()
    func onDismissAddPeriod()
}

class AddPeriodViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    static func storyboardInstance() -> AddPeriodViewController?
    {
        let storyboard = UIStoryboard( name: String( describing: self ), bundle: nil )
        return storyboard.instantiateInitialViewController() as? AddPeriodViewController
    }

    weak var delegate: AddPeriodDelegate?
    
    @IBAction func changeStartDate(_ sender: Any)
    {
        
    }

    @IBAction func changeEndDate(_ sender: Any)
    {
        
    }
    
    @IBAction func savePeriod(_ sender: Any)
    {
    }
    
    fileprivate let periodViewModel = PeriodViewModel ( dbService: FirebaseDBService() )
    

}
