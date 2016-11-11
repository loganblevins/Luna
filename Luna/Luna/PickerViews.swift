//
//  PickerViews.swift
//  Luna
//
//  Created by Erika Wilcox on 9/25/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation


class PickerViews
{
    init()
    {
        
    }
    
    func createRelationStatusPicker () -> [String]
    {
        let status = ["Single", "Casual Dating", "Committed Relationship"]
        
        return status
    }
    
    func createBirthControlPicker () -> [String]
    {
        let birthControls = ["None", "Diaphragm", "Cervical cap",
                             "IUD", "IUD Copper-based", "Implant", "Sponge", "Spermicide", "Injections",
                             "Pill", "Vaginal Ring", "Patch", "Male Condom", "Female Condom", "Natural Planning", "Other"]
        
        return birthControls
    }
    
    func createCycleLengths () -> [String]
    {
        var cycle = [String]()
        
        for c in stride(from: 0, through: 30, by: 1)
        {
            let day = String(c) + " days"
            
            cycle.append(day)
        }
        
        return cycle
    }
    
    func createPeriodLengths () -> [String]
    {
        var period = [String]()
        
        for p in stride(from: 0, through: 30, by: 1)
        {
            let day = String(p) + " days"
            
            period.append(day)
        }
        
        return period
    }
    
}














