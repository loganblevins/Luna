//
//  PickerViewController.swift
//  Luna
//
//  Created by Erika Wilcox on 9/25/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var optionsPicker: UIPickerView!
    
    var pickerValues: [String] = []
    var uidReceived: String!
    var uid: String!
    var onboardViewModel: OnBoardViewModel?
    var selectedData: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        uid = uidReceived
        onboardViewModel = OnBoardViewModel( uid: "dummy" /*uid*/ )
        
        self.optionsPicker.dataSource = self
        self.optionsPicker.delegate = self
        
        getPickerValues()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerValues[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selectedData = pickerValues[row]
    }
    
    
    func getPickerValues()
    {
        let page = pageControl.currentPage
        self.pickerValues = (onboardViewModel?.getPickerData( page))!
        
        //setDefaultPickerRow()
        
    }
    
    func setDefaultPickerRow()
    {
        let defaultRow = onboardViewModel?.getDefaultPickerValue( pageControl.currentPage)
        optionsPicker.selectedRow(inComponent: defaultRow!)
    }
    
    @IBAction func nextPressed(_ sender: AnyObject)
    {
        
        let page = onboardViewModel?.getDataType(pageControl.currentPage)
        let data = selectedData

        onboardViewModel?.saveInfo( page!, postData: data!)
        
        if(pageControl.currentPage != pageControl.numberOfPages)
        {
			let segueType = onboardViewModel?.getSegueType( pageControl.currentPage)
            self.performSegue(withIdentifier: segueType!, sender: nil)
        }

    }
	
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("identifier")
        print(segue.identifier!)
		
        
        //NEED TO CHANGE FOR DATE SEGUE
        if (segue.identifier == "toLastPeriod")
        {
            _ = segue.destination as! OnboardingViewController
//            pickerVC.uidReceived = onboardViewModel?.anonymousID
        }
        else
        {
            _ = segue.destination as! PickerViewController
//            pickerVC.uidReceived = onboardViewModel?.anonymousID
        }
        
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
