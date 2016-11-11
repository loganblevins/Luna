//
//  OBLastCycleViewController.swift
//  Luna
//
//  Created by Erika Wilcox on 11/8/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

class OBLastCycleViewController: UIViewController
{
    static func storyboardInstance() -> OBLastCycleViewController?
    {
        let storyboard = UIStoryboard( name: String( describing: self ), bundle: nil )
        return storyboard.instantiateInitialViewController() as? OBLastCycleViewController
    }
    
    weak var delegate: OnBoardDelegate?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        datePicker.datePickerMode = UIDatePickerMode.date
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextPressed(_ sender: AnyObject)
    {
        
        let date = datePicker.date
        
        lastCycleViewModel.onAddDataAttempt(data: date)
        {
            error in
            
        }
        
        self.delegate?.toDisorderView()
        
    }

    @IBOutlet weak var PageControl: UIPageControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    fileprivate let lastCycleViewModel = LastCycleViewModel ( dbService: FirebaseDBService() )

}
