//
//  AuthorizeViewController.swift
//  Luna
//
//  Created by Erika Wilcox on 9/23/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import Firebase

class AuthorizeViewController: UIViewController {

    @IBOutlet weak var userIDtextfield: UITextField!
    @IBOutlet weak var userPasswordtextfield: UITextField!
    
    var loginViewModel: LoginViewModel?
    
    required init!(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loginViewModel = LoginViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.anonymouseAuth()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LoginAttempt(_ sender: AnyObject) {

        let user =  userIDtextfield.text!
        let password = userPasswordtextfield.text!
        
        if (user != "" && password != "")
        {
            self.loginViewModel?.loginUser(username: user, userpassword: password, completion: { results in
                if (results)!
                {
                    print ("yes")
                    self.performSegue(withIdentifier: Constants().SEGUE_START_ONBOARD, sender: nil)
                }
                else
                {
                    print ("no")
                }
            })
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("identifier")
        print(segue.identifier)
        
        print("sender")
        print(sender)
        
        if(segue.identifier == Constants().SEGUE_START_ONBOARD)
        {
            let onBoardVC = segue.destination as! DatePickerViewController
            onBoardVC.uidReceived = loginViewModel?.anonymousID
            
        }
    }

    
    func anonymouseAuth()
    {
        self.loginViewModel?.anonymousAuth()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
