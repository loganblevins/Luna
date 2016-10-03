//
//  LoginViewController.swift
//  Luna
//
//  Created by Erika Wilcox on 9/23/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var userIDtextfield: UITextField!
    @IBOutlet weak var userPasswordtextfield: UITextField!
    
    var loginViewModel: LoginViewModel?
    
    required init!(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loginViewModel = LoginViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LoginAttempt(_ sender: AnyObject) {

        _ =  userIDtextfield.text!
        _ = userPasswordtextfield.text!
        
//        if ( user.isEmpty && password.isEmpty )
//        {
//            self.loginViewModel?.loginUser( user, userpassword: password )
//			{
//				results in
//                if (results)!
//                {
//                    print ("yes")
//                    self.performSegue(withIdentifier: Constants.InterfaceBuilderStrings.SegueStartOnboard, sender: nil)
//                }
//                else
//                {
//                    print ("no")
//                }
//            }
//        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("identifier")
        print(segue.identifier)
        
        print("sender")
        print(sender)
        
        if(segue.identifier == Constants.InterfaceBuilderStrings.SegueStartOnboard )
        {
            let onBoardVC = segue.destination as! DatePickerViewController
            onBoardVC.uidReceived = loginViewModel?.anonymousID
            
        }
    }

    
//    func anonymouseAuth()
//    {
//        self.loginViewModel?.anonymousAuth()
//    }
}
