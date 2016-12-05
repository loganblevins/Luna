//
//  OBDisorderViewController.swift
//  Luna
//
//  Created by Erika Wilcox on 11/8/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

class OBDisorderViewController: UIViewController, UITextFieldDelegate
{
	var itemIndex = 3

    static func storyboardInstance() -> OBDisorderViewController?
    {
        let storyboard = UIStoryboard( name: String( describing: self ), bundle: nil )
        return storyboard.instantiateInitialViewController() as? OBDisorderViewController
    }
	
	override func viewDidLoad()
	{
		disorderTextField.delegate = self
	}
	
    func maybeUploadData()
    {
        var uDisorder: String?
		guard let text = disorderTextField.text else { return }
		
        if text.isEmpty
        {
            uDisorder = "None"
        }
        else
        {
            if let text = disorderTextField.text
			{
				uDisorder = text
			}
        }
        
        disorderViewModel.onAddDataAttempt( data: uDisorder )
	}
	
	func textFieldShouldReturn(_ textField: UITextField ) -> Bool
	{
		textField.resignFirstResponder()
		return true
	}

    @IBOutlet fileprivate weak var disorderTextField: UITextField!
    
    fileprivate let disorderViewModel = DisorderViewModel( dbService: FirebaseDBService() )
}
