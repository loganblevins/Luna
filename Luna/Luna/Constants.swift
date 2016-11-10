//
//  Constants.swift
//  Luna
//
//  Created by Logan Blevins on 9/16/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

struct Constants
{
	struct InterfaceBuilderStrings
	{
		static let SegueStartOnboard = "startOnboard"
		static let SegueToHeight = "toHeight"
	}

	struct LunaStrings
	{
		static let BaseURL = "https://luna-track.com/api/v1/"
		static let UsernameKey = "username"
		static let PasswordKey = "password"
		static let LoginEndpoint = "auth/login/"
		static let MeEndpoint = "auth/me/"
		static let LogoutEndpoint = "auth/logout"
		static let ChangeUsernameEndpoint = "auth/username"
		static let ChangePasswordEndpoint = "auth/password"
		static let PasswordResetEndpoint = "auth/password/reset"
		static let PasswordResetConfirmEndpoint = "auth/password/reset/confirm"
		static let DeleteUserEndpoint = "auth/delete/"
		static let ActivateEndpoint = "auth/activate"
		static let RegisterEnpoint = "auth/register"
	}
	
	struct FirebaseStrings
	{
		static let BaseURL = "https://luna-c2c2f.firebaseio.com"
		static let ChildUsers = "Users"
		static let ChildEntry = "Entry"
		static let ChildDailyEntries = "DailyEntries"
		static let DictionaryUsernameKey = "Username"
	}
}
