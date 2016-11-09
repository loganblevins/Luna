//
//  FirebaseService.swift
//  Luna
//
//  Created by Erika Wilcox on 9/23/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Firebase

protocol ServiceAuthenticatable
{
	func signInUser( withToken token: String, completion: @escaping(_ userID: String?, _ error: Error? ) -> Void )
	func signOutUser() throws
}

protocol ServiceStorable
{
	// TODO: Fill in generic storage needs.
    func uploadUserImage( forUid uid: String, imageData: Data, imagePath: String, completion: @escaping(_ userID: String?, _ error: Error? ) -> Void)
    
    func addUserImageDownloadLink( forUid uid: String, downloadLink: String )

}

protocol ServiceDBManageable
{
	func createUserRecord( forUid uid: String, username: String )
    
    func getCurrentUser() -> FIRUser
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
	fileprivate static let FirebaseDB = FIRDatabase.database().reference()
	
	fileprivate var Users = FirebaseDB.child( Constants.FirebaseStrings.ChildUsers )
//	fileprivate var Entry = FirebaseDB.child( Constants.FirebaseStrings.ChildEntry )
//	fileprivate var DailyEntries = FirebaseDB.child( Constants.FirebaseStrings.ChildDailyEntries )
	
	func createUserRecord( forUid uid: String, username: String )
	{
		Users.child( uid ).setValue( [Constants.FirebaseStrings.DictionaryUsernameKey: username] )
		print( "Created user record in DB for uid: \( uid ), username: \( username )" )
	}
    
    func getCurrentUser() -> FIRUser
    {
        return (FIRAuth.auth()?.currentUser)!
    }
}
