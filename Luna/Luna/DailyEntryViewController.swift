//
//  DailyEntryViewController.swift
//  Luna
//
//  Created by Erika Wilcox on 11/12/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit


class DailyEntryViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        entryDate = valuePassed
    }
    
    @IBAction func startPressed(_ sender: Any)
    {
        dailyEntryViewModel.onAddStartDataAttempt(data: entryDate!)
        {
            error in
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func stopPressed(_ sender: Any)
    {
        dailyEntryViewModel.onAddEndDataAttempt(data: entryDate!)
        {
            error in
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    var valuePassed: Date?
    var entryDate: Date?
    
    fileprivate let dailyEntryViewModel = DailyEntryViewModel ( dbService: FirebaseDBService() )
    

}
