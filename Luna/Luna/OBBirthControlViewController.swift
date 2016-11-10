//
//  OBBirthControlViewController.swift
//  Luna
//
//  Created by Erika Wilcox on 11/8/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

class OBBirthControlViewController: UIViewController
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        }
       
        //NEED TO MOVE ON TO NEXT VIEW
    }

    fileprivate func setUIPickerView()
    {
        uiPickerValues = birthControlViewModel.getPickerValues()
    }
    
    
    @IBOutlet weak var birthControlPicker: UIPickerView!
    
    fileprivate var uiPickerValues: [String] = []
    fileprivate var selectedValue: String = ""
    
    fileprivate let birthControlViewModel = BirthControlViewModel( dbService: FirebaseDBService() )
    
    


}
