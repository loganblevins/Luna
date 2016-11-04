//
//  SettingsViewModel.swift
//  Luna
//
//  Created by Logan Blevins on 11/3/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation

class SettingsViewModel
{
	// MARK: Public API
	//
	
	init( withAuthService authService: ServiceAuthenticatable, databaseService: ServiceDBManageable )
	{
		self.authService = authService
		self.databaseService = databaseService
	}
	
	func logout() throws
	{
		try authService.signOutUser()
	}
	
	// MARK: Implementation Details
	//
	
	fileprivate let authService: ServiceAuthenticatable!
	fileprivate let databaseService: ServiceDBManageable!
}
