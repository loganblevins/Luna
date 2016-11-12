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
    
    weak var delegate: OnBoardDelegate?

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
        
        if imageSelected
        {
            let userImage = img.image
            
            let imgData = UIImageJPEGRepresentation(userImage!, 0.5)
            
            addImageViewModel.onUploadImageAttempt(imageData: imgData!)
            {
                error in
                
                
                
            }
            
            self.delegate?.toBirthControlView()
        }
        //NEED TO MOVE ON TO NEXT VIEW
    }
    
    @IBOutlet weak var img: UIImageView!
    
    fileprivate var imagePicker: UIImagePickerController!
    fileprivate var imageSelected = false

    fileprivate let addImageViewModel = AddImageViewModel( dbService: FirebaseDBService(), storageService: FirebaseStorageService() )

}
