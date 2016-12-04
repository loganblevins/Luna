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
    static func storyboardInstance() -> OBDisorderViewController?
    {
        let storyboard = UIStoryboard( name: String( describing: self ), bundle: nil )
        return storyboard.instantiateInitialViewController() as? OBDisorderViewController
    }
	
	override func viewDidLoad()
	{
		disorderTextField.delegate = self
	}
	
    weak var delegate: OnBoardDelegate?
    
    @IBAction func nextPressed(_ sender: AnyObject)
    {
        var uDisorder: String
        
        if ( disorderTextField.text?.isEmpty )!
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
        delegate?.toRelationshipView()
    }
	
	func textFieldShouldReturn(_ textField: UITextField ) -> Bool
	{
		textField.resignFirstResponder()
		return true
	}

    @IBOutlet fileprivate weak var disorderTextField: UITextField!
    
    fileprivate let disorderViewModel = DisorderViewModel( dbService: FirebaseDBService() )

}
