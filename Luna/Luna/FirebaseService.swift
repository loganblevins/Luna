//
//  FirebaseService.swift
//  Luna
//
//  Created by Erika Wilcox on 9/23/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Firebase

enum ServiceAuthenticatableError: Error, CustomStringConvertible
{
	case InvalidUser
	
	var description: String
	{
		switch self
		{
		case .InvalidUser:
			return "Current user is invalid."
		}
	}
}

protocol ServiceAuthenticatable
{
	func signInUser( withToken token: String, completion: @escaping(_ userID: String?, _ error: Error? ) -> Void )
	func signOutUser() throws
	func deleteUser( completion: @escaping(_ error: Error? ) -> Void )
}

protocol ServiceStorable
{
	// TODO: Fill in generic storage needs.
    func uploadUserImage( forUid uid: String, imageData: Data, imagePath: String, completion: @escaping(_ userID: String?, _ error: Error? ) -> Void)
    
    func addUserImageDownloadLink( forUid uid: String, downloadLink: String )

}

protocol ServiceDBManageable
{
	func waitForUserDeletion( forUid uid: String, completion: @escaping(_ error: Error? ) -> Void )
    func createUserRecord( forUid uid: String, username: String )
    func saveUserRecord( forUid uid: String, key: String, data: AnyObject )
	func deleteUserRecord( forUid uid: String )
    func retrieveUserRecord (forUid uid: String, completion: @escaping(_ error: Error?, _ userDictionary: Dictionary<String, AnyObject>? ) -> Void )
}

struct FirebaseAuthenticationService: ServiceAuthenticatable
{
	static func AuthChangeListener( completion: @escaping(_ user: FIRUser? ) -> Void ) -> FIRAuthStateDidChangeListenerHandle!
	{
		let handle = FIRAuth.auth()?.addStateDidChangeListener()
		{
			_, user in
			
			print( "Firebase auth state did change." )
			completion( user )
		}
		return handle!
	}
	
	static func RemoveAuthChangeListener(_ handle: FIRAuthStateDidChangeListenerHandle! )
	{
		FIRAuth.auth()?.removeStateDidChangeListener( handle )
	}
	
	func signInUser( withToken token: FirebaseToken, completion: @escaping(_ userID: String?, _ error: Error? ) -> Void )
	{
		print( "Attempting to sign in user." )
		
		FIRAuth.auth()?.signIn( withCustomToken: token )
		{
			userOrNil, errorOrNil in
			completion( userOrNil?.uid, errorOrNil )
		}
	}
	
	func signOutUser() throws
	{
		print( "Attempting to sign out user." )
		try FIRAuth.auth()?.signOut()
	}

	func deleteUser( completion: @escaping(_ error: Error? ) -> Void )
	{
		guard let user = currentUser else
		{
			completion( ServiceAuthenticatableError.InvalidUser )
			return
		}
		
		user.delete()
		{
			errorOrNil in
			completion( errorOrNil )
		}
	}
	
	// Firebase recommends to grab the current user from the auth state change handler,
	// but this should be safe, in some specific cases, e.g. `delete:` since the user
	// will already be logged in and initialized.
	// 
	// TODO: Grab current user that has been persisted from disk.
	//
	fileprivate var currentUser: FIRUser?
	{
		return FIRAuth.auth()?.currentUser
	}
}

struct FirebaseStorageService: ServiceStorable
{
    fileprivate static let FirebaseDB = FIRDatabase.database().reference()
    fileprivate static let FirebaseStorage = FIRStorage.storage().reference( forURL: Constants.FirebaseStrings.StorageURL )
    
    fileprivate var Users = FirebaseDB.child( Constants.FirebaseStrings.ChildUsers )
    fileprivate var StorageRef = FirebaseStorage
    
    func uploadUserImage( forUid uid: String, imageData: Data, imagePath: String, completion: @escaping(_ userID: String?, _ error: Error? ) -> Void)
    {
        print( "Attempting to upload user photo." )
        
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"
        
        
        let uploadTask = StorageRef.child( imagePath ).put(imageData, metadata: metadata)
        
        uploadTask.observe(.failure)
        {
            snapshot in
            
            guard let storageError = snapshot.error else { return }
            
            guard let errorCode = FIRStorageErrorCode(rawValue: storageError as! NSInteger) else { return }
            
            print ( "An error has occurred trying to upload photo: \(storageError)" )
            
            switch errorCode
            {
            case .objectNotFound:
                // File doesn't exist
                completion( uid , snapshot.error )
                break
                
            case .unauthorized:
                // User doesn't have permission to access file
                completion( uid , snapshot.error )
                break
                
            case .cancelled:
                // User canceled the upload
                completion( uid , snapshot.error )
                break
                
            case .unknown:
                // Unknown error occurred, inspect the server response
                completion( uid , snapshot.error )
                break
                
            default:
                completion( uid , snapshot.error )
                break
            }
        }
        
        
        uploadTask.observe(.success)
        {
            snapshot in
            
            print("Image upload a success")
            
            guard let downloadlink = snapshot.metadata?.downloadURL()?.absoluteString else { return }
            
            self.addUserImageDownloadLink( forUid: uid, downloadLink: downloadlink )
        }
    }
    
    
    func addUserImageDownloadLink( forUid uid: String, downloadLink: String )
    {
        Users.child( uid ).setValue( [Constants.FirebaseStrings.DictionaryUserImageKey: downloadLink] )
        print( "Add user image download url in DB for uid: \( uid ), downloadUrl: \( downloadLink )")
    }
    
}

struct FirebaseDBService: ServiceDBManageable
{
	func waitForUserDeletion( forUid uid: String, completion: @escaping(_ error: Error? ) -> Void )
	{
		Users.child( uid ).observeSingleEvent( of: .childRemoved, with:
		{
			snapshot in
			completion( nil )
		} )
		{
			error in
			print( error.localizedDescription )
			completion( error )
		}
	}
    
    func retrieveUserRecord (forUid uid: String, completion: @escaping(_ error: Error?, _ userDictionary: Dictionary<String, AnyObject>? ) -> Void )
    {
        Users.child( uid ).observe(FIRDataEventType.value, with:
        {
            snapshot in
            
            print (snapshot)
            
            guard let postDict = snapshot.value as? [String : AnyObject] else { return }
            
            completion ( nil, postDict )
            
        })
        {
            error in
            
            print( error.localizedDescription )
            completion( error, nil )
        }
        
        
    }
	
    func createUserRecord( forUid uid: String, username: String )
    {
        Users.child( uid ).setValue( [Constants.FirebaseStrings.DictionaryUsernameKey: username] )
        print( "Created user record in DB for uid: \( uid ), username: \( username )" )
    }
    
    func deleteUserRecord( forUid uid: String )
    {
        Users.child( uid ).removeValue()
        print( "Deleted user record in DB for uid: \( uid )" )
    }
    
    func saveUserRecord( forUid uid: String, key: String, data: AnyObject )
    {
        Users.child( uid ).setValue( [ key: data ] )
    }
    
    func isUserOnBoard( forUid uid: String ) -> Bool
    {
        return false
    }
	
	
	fileprivate static let FirebaseDB = FIRDatabase.database().reference()
	fileprivate var Users = FirebaseDB.child( Constants.FirebaseStrings.ChildUsers )

}
