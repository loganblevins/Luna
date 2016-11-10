//
//  OBMenstrualLenViewController.swift
//  Luna
//
//  Created by Erika Wilcox on 11/8/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

class OBMenstrualLenViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{

    static func storyboardInstance() -> OBMenstrualLenViewController?
    {
        let storyboard = UIStoryboard( name: String( describing: self ), bundle: nil )
        return storyboard.instantiateInitialViewController() as? OBMenstrualLenViewController
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
        lenControlPicker.dataSource = self
        lenControlPicker.delegate = self
        
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
            let valueInt = (selectedValue as NSString).integerValue
            
            menstrualLenViewModel.onAddDataAttempt(data: valueInt)
            {
                error in
                
                
                
            }
            
            self.delegate?.toLastCycleView()
        }
        
        //NEED TO MOVE ON TO NEXT VIEW
    }
    
    fileprivate func setUIPickerView()
    {
        uiPickerValues = menstrualLenViewModel.getPickerValues()
    }
    
    
    @IBOutlet weak var lenControlPicker: UIPickerView!
    
    fileprivate var uiPickerValues: [String] = []
    fileprivate var selectedValue: String = ""
    
    fileprivate let menstrualLenViewModel = MenstrualLenViewModel( dbService: FirebaseDBService() )
}
