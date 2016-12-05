//
//  PickerViews.swift
//  Luna
//
//  Created by Erika Wilcox on 9/25/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

class PickerViews
{
    func createRelationStatusPicker() -> [String]
    {
        return Constants.RelationshipValues.values
    }
    
    func createBirthControlPicker() -> [String]
    {
        return Constants.BirthControlValues.values
    }
    
    func createCycleLengths() -> [String]
    {
        var cycle = [String]()
        
        for c in stride( from: 0, through: 30, by: 1 )
        {
            let day = String( c ) + " Days"
            
            cycle.append( day )
        }
        
        return cycle
    }
    
    func createPeriodLengths () -> [String]
    {
        var period = [String]()
        
        for p in stride( from: 0, through: 30, by: 1 )
        {
            let day = String( p ) + " days"
            
            period.append( day )
        }
        
        return period
    }
}

