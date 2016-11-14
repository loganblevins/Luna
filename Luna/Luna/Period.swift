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
    var pid: String { get }
    var uid: String { get }
    var startDate: Date { get }
    var endDate: Date { get }
}

struct PeriodData: PeriodDataProtocol
{
    init( pid: String,
          uid: String,
          startDate: Date,
          endDate: Date)
    {
        self.pid = pid
        self.uid = uid
        self.startDate = startDate
        self.endDate = endDate
    }
    
    var pid: String
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
        self.pid = periodData.pid
        self.uid = periodData.uid
        self.startDate = periodData.startDate
        self.endDate = periodData.endDate
    }
    
    // MARK: Implementation details
    //
    fileprivate(set) var pid: String
    fileprivate(set) var uid: String
    fileprivate(set) var startDate: Date
    fileprivate(set) var endDate: Date

}
