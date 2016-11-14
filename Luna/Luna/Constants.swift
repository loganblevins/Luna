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
		static let confirmTitle = "Are you sure?"
		static let yesButtonTitle = "Yes"
		static let cancelButtonTitle = "Cancel"
		static let deleteUserConfirmMessage = "Deleting your account will purge all of your data."
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
	
	struct NetworkCodes
	{
		static let LunaDeleteAccountSuccess = 204
	}
	
	struct FirebaseStrings
	{
		static let BaseURL = "https://luna-c2c2f.firebaseio.com"
        static let StorageURL = "gs://luna-c2c2f.appspot.com"
		static let ChildUsers = "Users"
		static let ChildEntry = "Entry"
        static let ChildPeriods = "Periods"
		static let ChildDailyEntries = "DailyEntries"
		static let DictionaryUsernameKey = "Username"
        static let DictionaryOnBoardStatus = "OnBoardStatus"
        static let DictionaryUserImageKey = "UserImage"
        static let DictionaryUserBirthControl = "BirthControlType"
        static let DictionaryUserCycleDate = "DateLastCycle"
        static let DictionaryUserMenstrualLen = "MenstrualLen"
        static let DictionaryUserDisorder = "Disorder"
        static let DictionaryUserRelationshipStatus = "RelationshipStatus"
        static let DictionaryUserPeriods = "Periods"
        static let DictionaryPeriodUid = "uid"
        static let DictionaryPeriodStart = "start_date"
        static let DictionaryPeriodEnd = "end_date"
	}
    
    struct SettingsStrings
    {
        static let Relationship = "Relationship Status"
        static let BirthCtrl = "Birth Control Type"
        static let Disorder = "Reproductive Disorder"
        static let Periods = "Periods"
        static let toEditBirth = "toEditBirth"
        static let toEditRelationship = "toEditRelationship"
        static let toEditDisorder = "toEditDisorder"
        static let settingsCell = "settingsCell"
        static let periodCell = "periodCell"
        static let toEditPeriod = "toEditPeriod"
        static let toPeriods = "toPeriods"
    }
    
    struct HomeStrings
    {
        static let toEntry = "toEntry"
    }
    
    struct DailyEntry
    {
        static let startDate = "StartDate"
        static let endDate = "EndDate"
    }
    
    struct BirthControlValues
    {
        static let values = ["None", "Pill", "Vaginal Ring", "Patch", "Male Condom", "Female Condom", "Diaphragm", "Cervical cap", "IUD", "IUD Copper-based", "Implant", "Sponge", "Spermicide", "Injections", "Natural Planning", "Other"]
    }
    
    struct RelationshipValues
    {
        static let values = ["Single", "Casual Dating", "Committed Relationship"]
    }
    
    
}
