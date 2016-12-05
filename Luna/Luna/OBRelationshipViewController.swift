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
	var itemIndex = 4

    static func storyboardInstance() -> OBRelationshipViewController?
    {
        let storyboard = UIStoryboard( name: String( describing: self ), bundle: nil )
        return storyboard.instantiateInitialViewController() as? OBRelationshipViewController
    }
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        relationshipControlPicker.delegate = self
        relationshipControlPicker.dataSource = self
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
    
	func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int ) -> NSAttributedString?
	{
		let attributes = [NSForegroundColorAttributeName: UIColor.white]
		let text = NSAttributedString( string: uiPickerValues[row], attributes: attributes )
		return text
	}
	
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selectedValue = uiPickerValues[row]
    }
    
    @IBAction func continuePressed()
    {
		maybeUploadData()
		
	}
	
	func maybeUploadData()
	{
		if !selectedValue.isEmpty
		{
			relationshipStatusViewModel.onAddDataAttempt( data: selectedValue )
		}
	}
	
    fileprivate func setUIPickerView()
    {
        uiPickerValues = relationshipStatusViewModel.getPickerValues()
        
        if uiPickerValues.count > 0
        {
            if let value = uiPickerValues.first
			{
				selectedValue = value
			}
        }
    }
    
    @IBOutlet weak var relationshipControlPicker: UIPickerView!
    
    fileprivate var uiPickerValues: [String] = []
    fileprivate var selectedValue: String = ""
	
    fileprivate let relationshipStatusViewModel = RelationshipStatusViewModel( dbService: FirebaseDBService() )
}
