//
//  OBRelationshipViewController.swift
//  Luna
//
//  Created by Erika Wilcox on 11/8/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

class OBRelationshipViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{

    static func storyboardInstance() -> OBRelationshipViewController?
    {
        let storyboard = UIStoryboard( name: String( describing: self ), bundle: nil )
        return storyboard.instantiateInitialViewController() as? OBRelationshipViewController
    }
    
    weak var delegate: OnBoardDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        relationshipControlPicker.delegate = self
        relationshipControlPicker.dataSource = self
        setUIPickerView()
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
        
        if( !selectedValue.isEmpty )
        {
            relationshipStatusViewModel.onAddDataAttempt(data: selectedValue)
            {
                error in
            
            }
        }
        
        //NEED TO MOVE ON TO NEXT VIEW
        delegate?.onBoardComplete()
    }
    
    fileprivate func setUIPickerView()
    {
        uiPickerValues = relationshipStatusViewModel.getPickerValues()
        
        if(uiPickerValues.count > 0)
        {
            selectedValue = uiPickerValues[0]
        }
    }
    
    
    @IBOutlet weak var relationshipControlPicker: UIPickerView!
    
    fileprivate var uiPickerValues: [String] = []
    fileprivate var selectedValue: String = ""
    
    fileprivate let relationshipStatusViewModel = RelationshipStatusViewModel( dbService: FirebaseDBService() )

}
