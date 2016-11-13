//
//  HomeViewModel.swift
//  Luna
//
//  Created by Erika Wilcox on 11/12/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation

class HomeViewModel
{
    init( withAuthService authService: ServiceAuthenticatable, dbService: ServiceDBManageable )
    {
        self.authService = authService
        self.dbService = dbService
    }
    
    func saveUserDailyEntry(completion: @escaping(_ error: Error?, _ status: Bool? ) -> Void )
    {
        // Put network request on background thread.
        //
        DispatchQueue.global( qos: .userInitiated ).async
        {
            guard StandardDefaults.sharedInstance.uid != nil else
            {
                assertionFailure( "StandardDefaults returned bad uid." )
                return
            }
        }
    }
    
    
    
    fileprivate let lunaAPI = LunaAPI( requestor: LunaRequestor() )
    fileprivate let authService: ServiceAuthenticatable!
    fileprivate let dbService: ServiceDBManageable!
}
