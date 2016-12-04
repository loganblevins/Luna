//
//  OBMainViewController.swift
//  Luna
//
//  Created by Logan Blevins on 12/2/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

class OBPageViewController: UIPageViewController
{
	override func viewDidLoad()
	{
		super.viewDidLoad()
		dataSource = self
		setupPages()
	}
	
	static func storyboardInstance() -> OBPageViewController?
	{
		let storyboard = UIStoryboard( name: String( describing: self ), bundle: nil )
		return storyboard.instantiateInitialViewController() as? OBPageViewController
	}
	
	fileprivate func setupPages()
	{
		birthControlVC = OBBirthControlViewController.storyboardInstance()
		relationshipVC = OBRelationshipViewController.storyboardInstance()
		menstrualVC = OBMenstrualLenViewController.storyboardInstance()
		cycleVC = OBLastCycleViewController.storyboardInstance()
		disorderVC = OBDisorderViewController.storyboardInstance()
		
		guard let startPage = birthControlVC else { return }
		self.setViewControllers( [startPage], direction: .forward, animated: false, completion: nil )
	}
	
	fileprivate var birthControlVC: OBBirthControlViewController?
	fileprivate var relationshipVC: OBRelationshipViewController?
	fileprivate var menstrualVC: OBMenstrualLenViewController?
	fileprivate var cycleVC: OBLastCycleViewController?
	fileprivate var disorderVC: OBDisorderViewController?
}

extension OBPageViewController: UIPageViewControllerDataSource
{
	// MARK: UIPageViewControllerDataSource
	//
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController ) -> UIViewController?
	{
		switch viewController
		{
		case is OBBirthControlViewController:
			return nil
			
		case is OBMenstrualLenViewController:
			return birthControlVC
			
		case is OBLastCycleViewController:
			return menstrualVC
			
		case is OBDisorderViewController:
			return cycleVC
			
		case is OBRelationshipViewController:
			return disorderVC
			
		default:
			return nil
		}
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController ) -> UIViewController?
	{
		switch viewController
		{
		case is OBBirthControlViewController:
			return menstrualVC
			
		case is OBMenstrualLenViewController:
			return cycleVC
			
		case is OBLastCycleViewController:
			return disorderVC
			
		case is OBDisorderViewController:
			return relationshipVC
			
		case is OBRelationshipViewController:
			return nil
			
		default:
			return nil
		}
	}
	
	func presentationCount( for pageViewController: UIPageViewController ) -> Int
	{
		return 5
	}
	
	func presentationIndex( for pageViewController: UIPageViewController ) -> Int
	{
		return 0
	}
}
