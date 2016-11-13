//
//  SettingsDisorderViewController.swift
//  Luna
//
//  Created by Erika Wilcox on 11/12/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

class SettingsDisorderViewController: UIViewController
{

    static func storyboardInstance() -> SettingsDisorderViewController?
    {
        let storyboard = UIStoryboard( name: String( describing: self ), bundle: nil )
        return storyboard.instantiateInitialViewController() as? SettingsDisorderViewController
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    weak var delegate: SettingsDelegate?
    
    @IBAction func okPressed(_ sender: AnyObject)
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
        
        //delegate?.dismissEditDisorder()
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    @IBOutlet fileprivate weak var disorderTextField: UITextField!
    
    fileprivate let disorderViewModel = DisorderViewModel( dbService: FirebaseDBService() )

}
