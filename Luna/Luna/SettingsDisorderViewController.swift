//
//  SettingsDisorderViewController.swift
//  Luna
//
//  Created by Erika Wilcox on 11/12/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

class SettingsDisorderViewController: UIViewController, UITextFieldDelegate
{
    static func storyboardInstance() -> SettingsDisorderViewController?
    {
        let storyboard = UIStoryboard( name: String( describing: self ), bundle: nil )
        return storyboard.instantiateInitialViewController() as? SettingsDisorderViewController
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        disorderTextField.delegate = self
    }

    weak var delegate: SettingsDelegate?
	
	func textFieldShouldReturn(_ textField: UITextField ) -> Bool
	{
		textField.resignFirstResponder()
		return true
	}
	
    @IBAction fileprivate func okPressed(_ sender: AnyObject)
    {
        var uDisorder: String
		guard let text = disorderTextField.text else { return }
		
        if text.isEmpty
        {
            uDisorder = "None"
        }
        else
        {
            guard let text = disorderTextField.text else { return }
            uDisorder = text
        }
        
        disorderViewModel.onAddDataAttempt(data: uDisorder)
        {
            error in
            
        }
        
        //NEED TO MOVE ON TO NEXT VIEW
        
        //delegate?.dismissEditDisorder()
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet fileprivate weak var disorderTextField: UITextField!
    
    fileprivate let disorderViewModel = DisorderViewModel( dbService: FirebaseDBService() )

}
