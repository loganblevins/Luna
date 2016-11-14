//
//  DailyEntryViewModel.swift
//  Luna
//
//  Created by Erika Wilcox on 11/12/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation

class PeriodViewModel
{
    init( period: Period )
    {
        self.period = period
    }
    
    var pid: String
    {
        return period.pid
    }
        
    var startDate: Date
    {
        return period.startDate
    }
    
    var endDate: Date
    {
        return period.endDate
    }
    
    var uid: String
    {
        return period.uid
    }

    
    fileprivate var period: Period
}
