//
//  DatePickerViewController.swift
//  Luna
//
//  Created by Erika Wilcox on 9/24/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController, UIPageViewControllerDelegate {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var pageLabel: UILabel!
    
    var uidReceived: String!
    var uid: String!
    
    var onboardViewModel: OnBoardViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uid = uidReceived
        onboardViewModel = OnBoardViewModel( uid: uid )
        
        datePicker.datePickerMode = UIDatePickerMode.date
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func nextPressed(_ sender: AnyObject)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        let selectedDate = dateFormatter.string( from: datePicker.date )
        let page = onboardViewModel?.getDataType(key: pageControl.currentPage)
        
        if (pageControl.currentPage != 0)
        {
         onboardViewModel?.saveUserInfo(postType: page!, postData: selectedDate)
        }
        else
        {
            if (onboardViewModel?.calculateAge( birthday: datePicker.date ))!
            {
                onboardViewModel?.saveUserInfo(postType: page!, postData: selectedDate)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("identifier")
        print(segue.identifier)
        
        print("sender")
        print(sender)
        
    }
    
    



}
