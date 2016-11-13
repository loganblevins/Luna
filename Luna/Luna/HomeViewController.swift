//
//  HomeViewController.swift
//  Luna
//
//  Created by Logan Blevins on 11/3/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController
{

    fileprivate let retrieveModel = RetrieveViewModel(dbService: FirebaseDBService(), storageService: FirebaseStorageService() )

    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("@HOMELOADED")
        retrieveModel.fetchPhotos()

    }
}
