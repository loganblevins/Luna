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
    var age: Int
    {
        return calculateAge( (user.birthday) )
    }
	
    init( user: User )
    {
        self.user = user
    }
    
    func calculateAge ( _ birthday: Date ) -> Int
    {
        let ageComps = Calendar.current.dateComponents( [.year], from: birthday, to: Date() )
        
        let age = ageComps.year!
        
        return age
    }
    
    fileprivate var user: User
}

