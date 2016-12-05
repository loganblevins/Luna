//
//  SettingsBirthControlViewController.swift
//  Luna
//
//  Created by Erika Wilcox on 11/12/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

class SettingsBirthControlViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate
{

    static func storyboardInstance() -> SettingsBirthControlViewController?
    {
        let storyboard = UIStoryboard( name: String( describing: self ), bundle: nil )
        return storyboard.instantiateInitialViewController() as? SettingsBirthControlViewController
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        birthControlPicker.delegate = self
        birthControlPicker.dataSource = self
        setUIPickerView()
        setSelectedValue()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    weak var delegate: SettingsDelegate?
    
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
    
    @IBAction func okPressed(_ sender: AnyObject)
    {
        
        if( !selectedValue.isEmpty )
        {
            birthControlViewModel.onAddDataAttempt(data: selectedValue)
            {
                error in
                
            }
        }
        
        //NEED TO MOVE ON TO NEXT VIEW
        //delegate?.dismissEditBirthControl()
        _ = navigationController?.popViewController(animated: true)
    }
    
    fileprivate func setUIPickerView()
    {
        uiPickerValues = birthControlViewModel.getPickerValues()
        
    }
    
    fileprivate func setSelectedValue()
    {
        if(uiPickerValues.count > 0)
        {
            if( !selectedValue.isEmpty )
            {
                let row = uiPickerValues.index(of: selectedValue)
                birthControlPicker.selectRow(row!, inComponent: 0, animated: false)
            }
            else
            {
                guard let defaultValue = birthControlViewModel.getBirthControlData() else
                {
                    return
                }
                
                let row = uiPickerValues.index(of: defaultValue)
                birthControlPicker.selectRow(row!, inComponent: 0, animated: false)

            }
        }
    }
    
    
    @IBOutlet weak var birthControlPicker: UIPickerView!
    
    fileprivate var uiPickerValues: [String] = []
    var selectedValue: String = ""
    
    fileprivate let birthControlViewModel = BirthControlViewModel( dbService: FirebaseDBService() )
    

}
