//
//  OnBoardViewModel.swift
//  Luna
//
//  Created by Erika Wilcox on 9/24/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

class OnBoardViewModel
{
//    var userService: UserService
    var uid: String
    var dataTypes: Dictionary<Int, String>
    var segueTypes: Dictionary<Int, String>
    var pickerView: PickerViews
    
    init( uid: String )
    {
//        userService = UserService()
        pickerView = PickerViews()
        self.uid = uid
        
        dataTypes = [0: "Birthday", 1:"Height", 2: "Weight", 3:"CycleLength", 4: "PeriodLength", 5:"LastPeriod", 6:"BirthControl"]
        segueTypes = [0: "toHeight", 1:"toWeight", 2: "toCycleLen", 3:"toPeriodLen", 4: "toLastPeriod", 5:"toBirthControl"]
        
    }
    

    
    func calculateAge ( _ birthday: Date ) -> Bool
    {
        let ageComps = Calendar.current.dateComponents([.year], from: birthday, to: Date() as Date)
        
        let age = ageComps.year!
        
        if ( age > 17 )
        {
            return true
        }
        else
        {
            return false
        }
        
    }
    
    func getDefaultPickerValue ( _ type: Int ) -> Int
    {
        return pickerView.selectDefaultValues(type)
    }
    
    func getPickerData ( _ page: Int ) -> [String]
    {
        return pickerView.selectPicker(page)
    }
    
    func getDataType ( _ key: Int ) -> String
    {
        return dataTypes[key]!
    }
    
    func getSegueType ( _ segue: Int ) -> String
    {
        return segueTypes[segue]!
    }
    
    ////NEED TO FORMAT THE DATA BEING SET TO THE DATABASE
    /// AS OF NOW IT IS GETTING SENT AS A STRING (EX. '5 FT 5 IN')
    // THIS SHOULD REALLY NOT BE SAVED IN THIS FORMAT
    func saveInfo ( _ postType: String, postData: String )
    {
//        userService.postData(uid: anonymousID, postType: postType, postData: postData)
    }

}
