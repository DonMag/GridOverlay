//
//  ViewController.swift
//  GridOverlay
//
//  Created by Don Mag on 11/1/22.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

	@IBOutlet var scrollView: UIScrollView!
	@IBOutlet var imgView: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		scrollView.delegate = self
	}
	
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return imgView
	}

}

