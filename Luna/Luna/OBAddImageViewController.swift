//
//  OBAddImageViewController.swift
//  Luna
//
//  Created by Erika Wilcox on 11/7/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

class OBAddImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    static func storyboardInstance() -> OBAddImageViewController?
    {
        let storyboard = UIStoryboard( name: String( describing: self ), bundle: nil )
        return storyboard.instantiateInitialViewController() as? OBAddImageViewController
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()

        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?)
    {
        imagePicker.dismiss(animated: true, completion: nil)
        img.image = image
        imageSelected = true
    }
    
    @IBAction func imageTap(_ sender: UITapGestureRecognizer)
    {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func nextPressed(_ sender: AnyObject)
    {
        
                
    }
    
    fileprivate func handleLoginError(_ error: Error )
    {
        switch error
        {
        case is LunaAPIError:
            let e = error as! LunaAPIError
            print( e.description )
            
        case is NetworkError:
            let e = error as! NetworkError
            print( e.description )
            
        default:
            print( error.localizedDescription )
        }
    }
    
    
    @IBOutlet weak var img: UIImageView!
    
    fileprivate var imagePicker: UIImagePickerController!
    fileprivate var imageSelected = false

    fileprivate let addImageViewModel = AddImageViewModel( dbService: FirebaseDBService(), storageService: FirebaseStorageService() )

}