//
//  UserViewModel.swift
//  Luna
//
//  Created by Erika Wilcox on 9/23/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation

//protocol UserViewable
//{
//    var birthControlType: String { get }
//    var relationshipStatus: String { get }
//    var disorder: String { get }
//}

final class UserViewModel
{
	// MARK: Public API
	//
    
    var birthControl: String
    {
        return user.birthControl
    }
	
    var relationshipStatus: String
    {
        return user.relationshipStatus
    }
    
    var disorder: String
    {
        return user.disorder
    }
    
	
	init( user: User )
    {
        self.user = user
		//self.userViewable = userViewable
    }
    

	// MARK: Implementation details
	//
	
    fileprivate var user: User
	//fileprivate var userViewable: UserViewable
}

