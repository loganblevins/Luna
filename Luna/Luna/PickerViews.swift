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
    
    /*func selectDefaultValues ( _ type: Int ) -> Int
    {
        switch type
        {
        case 1:
            return 1
        case 2:
            return 2
        case 3:
            return 28
        case 4:
            return 5
        case 6:
            return 1
        default:
            return 1
        }
    }
    
    func selectPicker ( _ type: Int ) -> [String]
    {
        
        switch type
        {
        case 1:
            return createHeightPicker()
        case 2:
            return createWeightPicker()
        case 3:
            return createCycleLengths()
        case 4:
            return createPeriodLengths()
        case 6:
            return createBirthControlPicker()
        default:
            return [String]()
        }
    }*/
    
    func createRelationStatusPicker () -> [String]
    {
        let status = ["Single", "Casual Dating", "Committed Relationship"]
        
        return status
    }
    
    func createBirthControlPicker () -> [String]
    {
        let birthControls = ["None", "Male Condom", "Female Condom", "Diaphragm", "Cervical cap",
                             "IUD", "IUD Copper-based", "Implant", "Sponge", "Spermicide", "Injections",
                             "Pill", "Vaginal Ring", "Patch", "Natural Planning", "Other"]
        
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














