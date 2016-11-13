//
//  Period.swift
//  Luna
//
//  Created by Erika Wilcox on 11/13/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation


protocol PeriodDataProtocol
{
    var uid: String { get }
    var startDate: Date { get }
    var endDate: Date { get }
}

struct PeriodData: PeriodDataProtocol
{
    init( uid: String,
          startDate: Date,
          endDate: Date)
    {
        self.uid = uid
        self.startDate = startDate
        self.endDate = endDate
    }
    
    var uid: String
    var startDate: Date
    var endDate: Date
    
}

final class Period
{
    // MARK: Public API
    //
    
    init( periodData: PeriodDataProtocol )
    {
        self.uid = periodData.uid
        self.startDate = periodData.startDate
        self.endDate = periodData.endDate
    }
    
    // MARK: Implementation details
    //
    
    fileprivate(set) var uid: String
    fileprivate(set) var startDate: Date
    fileprivate(set) var endDate: Date

}
