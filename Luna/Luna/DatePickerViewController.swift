//
//  OnboardingViewController.swift
//  Luna
//
//  Created by Erika Wilcox on 9/24/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, UIPageViewControllerDelegate {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var uidReceived: String!
    var uid: String!
    
    var onboardViewModel: OnBoardViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uid = uidReceived
        onboardViewModel = OnBoardViewModel( uid: "dummyUID" /*uid*/ )
        
        datePicker.datePickerMode = UIDatePickerMode.date
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func nextPressed(_ sender: AnyObject)
    {
        var success = false
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        let selectedDate = dateFormatter.string( from: datePicker.date )
        let page = onboardViewModel?.getDataType( pageControl.currentPage )
        
        if (pageControl.currentPage != 0)
        {
            onboardViewModel?.saveInfo(page!, postData: selectedDate)
        
            success = true
        }
        else
        {
            if (onboardViewModel?.calculateAge( datePicker.date ))!
            {
                onboardViewModel?.saveInfo(page!, postData: selectedDate)
                
                success = true
            }
        }
        
        if(success)
        {
            let segueType = onboardViewModel?.getSegueType(pageControl.currentPage)
            
            self.performSegue(withIdentifier: segueType!, sender: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("identifier")
        print(segue.identifier)
        
        print("sender")
        print(sender)
        
        if (segue.identifier != nil)
        {
            _ = segue.destination as! PickerViewController
//            pickerVC.uidReceived = onboardViewModel?.anonymousID
        }
        
    }
    
    



}
