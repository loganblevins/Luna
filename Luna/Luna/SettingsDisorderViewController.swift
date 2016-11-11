//
//  SettingsDisorderViewController.swift
//  Luna
//
//  Created by Erika Wilcox on 11/10/16.
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextPressed(_ sender: AnyObject)
    {
        var uDisorder: String
        
        if (disorderTextField.text == "")
        {
            uDisorder = "None"
        }
        else
        {
            uDisorder = disorderTextField.text!
        }
        
        disorderViewModel.onAddDataAttempt(data: uDisorder)
        {
            error in
            
            
        }
        
        //self.delegate?.toRelationshipView()
    }

    @IBOutlet fileprivate weak var disorderTextField: UITextField!
    
    fileprivate let disorderViewModel = DisorderViewModel( dbService: FirebaseDBService() )
}
