//
//  SettingsPeriodsViewModel.swift
//  Luna
//
//  Created by Erika Wilcox on 11/13/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation

class SettingsPeriodsViewModel
{
    init( databaseService: ServiceDBManageable )
    {
        self.databaseService = databaseService
    }
    
    var periods: [PeriodViewModel]?
    fileprivate let databaseService: ServiceDBManageable!
    
}
