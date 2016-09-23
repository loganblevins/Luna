//
//  Post.swift
//  Luna
//
//  Created by Erika Wilcox on 9/23/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import Foundation
import Firebase

protocol  Post
{
    func postDataToFirebase ( postType: String, postData: AnyObject )
    
    func postToFirbase ()
}
