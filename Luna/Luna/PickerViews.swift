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
    
    func selectDefaultValues ( _ type: Int ) -> Int
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
    }
    
    func createHeightPicker () -> [String]
    {
        var heights = [String]()
        
        for i in stride(from: 1, through: 9, by: 1)
        {
            let firstValue: String = String(i)
            
            for j in stride(from: 1, through: 10, by: 1)
            {
                let inch: String = String(j)
                
                let totalHeight = firstValue + " ft " + inch + " in"
                heights.append(totalHeight)
            }
        }

        return heights

    }
    
    
    func createWeightPicker () -> [String]
    {
        var weights = [String]()
        
        for w in stride(from: 50, through: 700, by: 1)
        {
            let weight = String(w) + " lb"
            
            weights.append(weight)
        }
        
        return weights
    }
    
    func createBirthControlPicker () -> [String]
    {
        let birthControls = ["None", "Pill", "Vaginal Ring", "Patch", "IUD", "Implant", "Other"]
        
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














