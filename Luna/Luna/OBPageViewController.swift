//
//  OBMainViewController.swift
//  Luna
//
//  Created by Logan Blevins on 12/2/16.
//  Copyright © 2016 Logan Blevins. All rights reserved.
//

import UIKit

protocol OnBoardCompletionDelegate: class
{
	func onOnboardComplete()
}

class OBPageViewController: UIPageViewController
{
	weak var onboardCompletionDelegate: OnBoardCompletionDelegate?
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		dataSource = self
		delegate = self
		setupPages()
	}
	
	static func storyboardInstance() -> OBPageViewController?
	{
		let storyboard = UIStoryboard( name: String( describing: self ), bundle: nil )
		return storyboard.instantiateInitialViewController() as? OBPageViewController
	}
	
	func onboardComplete()
	{
		onboardCompletionDelegate?.onOnboardComplete()
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
	fileprivate var currentIndex: Int = 0
	fileprivate var nextIndex: Int = 0
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

extension OBPageViewController: UIPageViewControllerDelegate
{
	func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController] )
	{
		let viewController = pendingViewControllers.first
		switch viewController
		{
		case is OBBirthControlViewController:
			let targetVC = viewController as! OBBirthControlViewController
			nextIndex = targetVC.itemIndex
			maybeUploadDataFor( vc: targetVC )
			
		case is OBMenstrualLenViewController:
			let targetVC = viewController as! OBMenstrualLenViewController
			nextIndex = targetVC.itemIndex
			maybeUploadDataFor( vc: targetVC )

		case is OBLastCycleViewController:
			let targetVC = viewController as! OBLastCycleViewController
			nextIndex = targetVC.itemIndex
			maybeUploadDataFor( vc: targetVC )

		case is OBDisorderViewController:
			let targetVC = viewController as! OBDisorderViewController
			nextIndex = targetVC.itemIndex
			maybeUploadDataFor( vc: targetVC )

		case is OBRelationshipViewController:
			let targetVC = viewController as! OBRelationshipViewController
			nextIndex = targetVC.itemIndex
			maybeUploadDataFor( vc: targetVC )

		default:
			return
		}
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool )
	{
		if completed
		{
			currentIndex = nextIndex
		}
	}
	
	fileprivate func maybeUploadDataFor( vc: UIViewController )
	{
		// Are we going forward?
		//
		if nextIndex > currentIndex
		{
			switch vc
			{
			case is OBMenstrualLenViewController:
				birthControlVC?.maybeUploadData()
				
			case is OBLastCycleViewController:
				menstrualVC?.maybeUploadData()
				
			case is OBDisorderViewController:
				cycleVC?.maybeUploadData()
				
			case is OBRelationshipViewController:
				disorderVC?.maybeUploadData()
				
			default:
				return
			}
		}
		else if nextIndex < currentIndex // Or backward?
		{
			switch vc
			{
			case is OBBirthControlViewController:
				menstrualVC?.maybeUploadData()
				
			case is OBMenstrualLenViewController:
				cycleVC?.maybeUploadData()
				
			case is OBLastCycleViewController:
				disorderVC?.maybeUploadData()
				
			default:
				return
			}
		}
	}
}
