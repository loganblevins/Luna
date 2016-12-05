//
//  OBLastCycleViewController.swift
//  Luna
//
//  Created by Erika Wilcox on 11/8/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

class OBLastCycleViewController: UIViewController
{
	var itemIndex = 2

    static func storyboardInstance() -> OBLastCycleViewController?
    {
        let storyboard = UIStoryboard( name: String( describing: self ), bundle: nil )
        return storyboard.instantiateInitialViewController() as? OBLastCycleViewController
    }
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		// This method is really sketchy and I hate it, but it works!
		// Natively, the UIDatePicker is not meant to be customizable.
		// This is sort of a hack...
		//
		datePicker.setValue( UIColor.white, forKey: "textColor" )
	}
	
    func maybeUploadData()
    {
        let date = datePicker.date
        lastCycleViewModel.onAddDataAttempt( data: date )
    }

    @IBOutlet weak var datePicker: UIDatePicker!
    
    fileprivate let lastCycleViewModel = LastCycleViewModel ( dbService: FirebaseDBService() )
}
