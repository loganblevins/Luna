//
//  OBDisorderViewController.swift
//  Luna
//
//  Created by Erika Wilcox on 11/8/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

class OBDisorderViewController: UIViewController
{
    static func storyboardInstance() -> OBDisorderViewController?
    {
        let storyboard = UIStoryboard( name: String( describing: self ), bundle: nil )
        return storyboard.instantiateInitialViewController() as? OBDisorderViewController
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
        
        self.delegate?.toRelationshipView()
    }

    @IBOutlet weak var PageControl: UIPageControl!
    @IBOutlet fileprivate weak var disorderTextField: UITextField!
    
    fileprivate let disorderViewModel = DisorderViewModel( dbService: FirebaseDBService() )

}
