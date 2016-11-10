//
//  HomeViewModel.swift
//  Luna
//
//  Created by Logan Blevins on 10/5/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

class MainViewModel
{
    init( dbService: ServiceDBManageable )
    {
        self.dbService = dbService
    }

    func checkOnBoardStatus(completion: @escaping(_ result: Bool? ) -> Void )
    {
        let user = dbService.getCurrentUser()
        
        dbService.getUserOnBoardStatus( forUid: user.uid )
        {
            status in
            
            let onBoardStatus = status! as Bool
            
            if(onBoardStatus)
            {
                print("User already onboarded")
                
                completion( onBoardStatus )
            }
            else
            {
                print("User needs to on board")
                
                completion( onBoardStatus )
            }
            
        }
        
        
    }
    func setOnBoardComplete()
    {
        let user = dbService.getCurrentUser()
        
        dbService.setOnBoardStatus( forUid: user.uid , status: true )
    }
    
    // MARK: Implementation Details
    //
    
    fileprivate let lunaAPI = LunaAPI( requestor: LunaRequestor() )
    fileprivate let dbService: ServiceDBManageable!
}
