//
//  EditPeriodViewController.swift
//  Luna
//
//  Created by Erika Wilcox on 11/13/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

protocol EditPeriodDelegate: class
{
    func presentEditPeriod()
    func onDismissAddPeriod()
}

class EditPeriodViewController: UIViewController
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        startDateLabel.text = convertDateFormatToString( date: Date() )
        endDateLabel.text = convertDateFormatToString( date: Date() )
        lenLabel.text = "\(5)"
        
        datePicker.datePickerMode = UIDatePickerMode.date
        
        setStartView()
        
        editPeriodViewModel.setDates()
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
        
        datePicker.setDate( editPeriodViewModel.Start, animated: true )
    }
    @IBAction func changePeriodEndDate(_ sender: Any)
    {
        endPicker = true
        startPicker = false
        
        print("hit end button")
        setEndView()
        
        datePicker.setDate( editPeriodViewModel.End, animated: true )
        
    }
    
    
    @IBAction func savePeriod(_ sender: Any)
    {
        createPeriodObject()
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
        endView.backgroundColor = UIColor.gray
    }
    
    fileprivate func setStartView()
    {
        startPicker = true
        startView.backgroundColor = UIColor.gray
        
        endPicker = false
        endView.backgroundColor = UIColor.clear
    }
    
    fileprivate func createPeriodObject()
    {
        editPeriodViewModel.onCreatePeriodObject(startDate: convertDateFormatToString( date: editPeriodViewModel.Start ), endDate: convertDateFormatToString( date: editPeriodViewModel.End ))
        {
            error in
        }
    }
    
    fileprivate func setLabelDates()
    {
        startDateLabel.text = convertDateFormatToString( date: editPeriodViewModel.Start )
        endDateLabel.text = convertDateFormatToString( date: editPeriodViewModel.End )
        lenLabel.text =  "\(editPeriodViewModel.Length)"
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
        editPeriodViewModel.Start = datePicker.date
    }
    
    fileprivate func updateEndDate()
    {
        editPeriodViewModel.End = datePicker.date
    }
    
    fileprivate func updateLen()
    {
        let d  = Calendar.current.dateComponents([.day], from: editPeriodViewModel.Start, to: editPeriodViewModel.End).day
        editPeriodViewModel.Length = d! + 1
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
    
    fileprivate let editPeriodViewModel = EditPeriodViewModel ( dbService: FirebaseDBService() )
    
    
}

