//
//  HomeViewModel.swift
//  Luna
//
//  Created by Logan Blevins on 10/5/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//
import Foundation

class MainViewModel
{
    // MARK: Public API
    //
    
    init( withAuthService authService: ServiceAuthenticatable, dbService: ServiceDBManageable )
    {
        self.authService = authService
        self.dbService = dbService
    }
    
    func checkOnBoardStatus( completion: @escaping(_ error: Error?, _ status: Bool? ) -> Void )
    {
		guard let uid = StandardDefaults.sharedInstance.uid else
		{
			assertionFailure( "StandardDefaults returned bad uid." )
			return
		}
		
        // Put network request on background thread.
        //
        DispatchQueue.global( qos: .userInitiated ).async
        {
            self.dbService.checkUserOnBoardStatus( forUid: uid )
            {
                error, status in
                
                completion( error, status )
            }
        }
    }

    func setOnBoardStatus( status: Bool ) -> Void
    {
        guard let uid = StandardDefaults.sharedInstance.uid else
        {
            assertionFailure( "StandardDefaults returned bad uid." )
            return
        }
        
        dbService.saveUserRecord( forUid: uid, key: Constants.FirebaseStrings.DictionaryOnBoardStatus, data: status as AnyObject )
    }
    
    fileprivate let lunaAPI = LunaAPI( requestor: LunaRequestor() )
    fileprivate let authService: ServiceAuthenticatable!
    fileprivate let dbService: ServiceDBManageable!
}
