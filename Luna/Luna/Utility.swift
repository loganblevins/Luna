//
//  Utility.swift
//  Luna
//
//  Created by Logan Blevins on 9/16/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

func root( view: UIView ) -> UIViewController?
{
	return view.window?.rootViewController
}

func rootPresent( fromView: UIView, controller: UIViewController, animated flag: Bool = true, completion: (() -> Void)? = nil ) -> Bool
{
	guard let root = root( view: fromView ) else { return false }
	root.present( controller, animated: flag, completion: completion )
	return true
}

func rootDismiss( fromView: UIView, controller: UIViewController, animated flag: Bool = true, completion: (() -> Void)? = nil )
{
	root( view: fromView )?.dismiss( animated: flag, completion: completion )
}

func presented( view: UIView ) -> UIViewController?
{
	return root( view: view )?.presentedViewController
}
