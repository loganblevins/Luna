//
//  UserViewModel.swift
//  Luna
//
//  Created by Erika Wilcox on 9/23/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation

protocol UserViewable
{
	var age: Int { get }
}

final class UserViewModel
{
	// MARK: Public API
	//
	
    var age: Int
    {
        return calculateAge( (user.birthday) )
    }
	
	init( user: User, userViewable: UserViewable )
    {
        self.user = user
		self.userViewable = userViewable
    }
    
    func calculateAge ( _ birthday: Date ) -> Int
    {
        let ageComps = Calendar.current.dateComponents( [.year], from: birthday, to: Date() )
        
        let age = ageComps.year!
        
        return age
    }
	
	// MARK: Implementation details
	//
	
    fileprivate var user: User
	fileprivate var userViewable: UserViewable
}

