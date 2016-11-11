//
//  OBBirthControlViewController.swift
//  Luna
//
//  Created by Erika Wilcox on 11/8/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

class OBBirthControlViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{

    static func storyboardInstance() -> OBBirthControlViewController?
    {
        let storyboard = UIStoryboard( name: String( describing: self ), bundle: nil )
        return storyboard.instantiateInitialViewController() as? OBBirthControlViewController
    }
    
    weak var delegate: OnBoardDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initPicker()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initPicker()
    {
        birthControlPicker.dataSource = self
        birthControlPicker.delegate = self
        
        setUIPickerView()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return uiPickerValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return uiPickerValues[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selectedValue = uiPickerValues[row]
    }
    
    @IBAction func nextPressed(_ sender: AnyObject)
    {
        
        if( selectedValue != "")
        {
            birthControlViewModel.onAddDataAttempt(data: selectedValue)
            {
                error in
                
            }
            
            self.delegate?.toMenstrualLenView()
        }

    }

    fileprivate func setUIPickerView()
    {
        uiPickerValues = birthControlViewModel.getPickerValues()
        
        if (uiPickerValues.count > 0)
        {
            selectedValue = uiPickerValues[0]
        }
    }
    
    
    @IBOutlet weak var PageControl: UIPageControl!
    @IBOutlet weak var birthControlPicker: UIPickerView!
    
    fileprivate var uiPickerValues: [String] = []
    fileprivate var selectedValue: String = ""
    
    fileprivate let birthControlViewModel = BirthControlViewModel( dbService: FirebaseDBService() )
    
    


}
