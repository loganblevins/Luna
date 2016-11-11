//
//  UserViewModel.swift
//  Luna
//
//  Created by Erika Wilcox on 9/23/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation


final class UserViewModel
{
	// MARK: Public API
	//
    
	init( user: User )
    {
        self.user = user
    }
    
    func getUser() -> User
    {
        return user
    }
	// MARK: Implementation details
	//
	
    fileprivate var user: User
}

