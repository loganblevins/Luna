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
        
        startDateLabel.text = convertDateFormatToString( date: Date() )
        endDateLabel.text = convertDateFormatToString( date: Date() )
        lenLabel.text = "\(5)"
        
        datePicker.datePickerMode = UIDatePickerMode.date

        setStartView()
        
        addPeriodViewModel.setDates()
        {
            errorOrNil in
            
            guard errorOrNil == nil else
            {
                return
            }
            
            self.setLabelDates()
        }
    }
    
    static func storyboardInstance() -> AddPeriodViewController?
    {
        let storyboard = UIStoryboard( name: String( describing: self ), bundle: nil )
        return storyboard.instantiateInitialViewController() as? AddPeriodViewController
    }

    weak var delegate: AddPeriodDelegate?
    
    @IBAction func changePeriodStartDate(_ sender: Any)
    {
        startPicker = true
        endPicker = false
        
        print("hit start button")
        setStartView()
        
        datePicker.setDate( addPeriodViewModel.Start, animated: true )
    }
    @IBAction func changePeriodEndDate(_ sender: Any)
    {
        endPicker = true
        startPicker = false
        
        print("hit end button")
        setEndView()
        
        datePicker.setDate( addPeriodViewModel.End, animated: true )
        
    }

    
    @IBAction func savePeriodObject(_ sender: Any)
    {
        createPeriodObject()
        
        delegate?.onDismissAddPeriod()
    }

    
    @IBAction func cancelAddPeriod(_ sender: Any)
    {
        delegate?.onDismissAddPeriod()
    }
    
    @IBAction func datePickerChange(_ sender: Any)
    {
        print("Date picker date change")
        print("New date: \(datePicker.date)")
        
        if endPicker
        {
            updateEndDate()
        }
        if startPicker
        {
            updateStartDate()
        }
        updateLen()
        setLabelDates()
    }
    
    fileprivate func setEndView()
    {
        startPicker = false
        startView.backgroundColor = UIColor.clear
        
        endPicker = true
        endView.backgroundColor = UIColor.lightGray
    }
    
    fileprivate func setStartView()
    {
        startPicker = true
        startView.backgroundColor = UIColor.lightGray
        
        endPicker = false
        endView.backgroundColor = UIColor.clear
    }

    fileprivate func createPeriodObject()
    {
        addPeriodViewModel.onCreatePeriodObject(startDate: convertDateFormatToUnixString(date: addPeriodViewModel.Start ), endDate: convertDateFormatToUnixString( date: addPeriodViewModel.End ))
        {
            error in
        }
    }
    
    fileprivate func setLabelDates()
    {
        startDateLabel.text = convertDateFormatToString( date: addPeriodViewModel.Start )
        endDateLabel.text = convertDateFormatToString( date: addPeriodViewModel.End )
        lenLabel.text =  "\(addPeriodViewModel.Length)"
    }
    
    fileprivate func convertDateFormatToUnixString( date: Date ) -> String
    {
        let timestamp = date.timeIntervalSince1970
        
        return String(format: "%f", timestamp)
    }
    
    fileprivate func convertDateFormatToString( date: Date ) -> String
    {
        let currentDate = date
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.long
        
        return dateFormatter.string(from: currentDate)
    }
    
    fileprivate func updateStartDate()
    {
        addPeriodViewModel.Start = datePicker.date
    }
    
    fileprivate func updateEndDate()
    {
        addPeriodViewModel.End = datePicker.date
    }
    
    fileprivate func updateLen()
    {
        let d  = Calendar.current.dateComponents([.day], from: addPeriodViewModel.Start, to: addPeriodViewModel.End).day
        addPeriodViewModel.Length = d! + 1
    }
    
 
    @IBOutlet weak var startView: UIView!
    @IBOutlet weak var endView: UIView!
    
    fileprivate var startDate: Date?
    fileprivate var endDate: Date?
    
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var lenLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    fileprivate var startPicker: Bool = false
    fileprivate var endPicker: Bool = false
    
    fileprivate let addPeriodViewModel = AddPeriodViewModel ( dbService: FirebaseDBService() )
    

}
