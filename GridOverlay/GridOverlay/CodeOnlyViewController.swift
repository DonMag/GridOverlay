//
//  CodeOnlyViewController.swift
//  GridOverlay
//
//  Created by Don Mag on 11/2/22.
//

import UIKit

class CodeOnlyViewController: UIViewController, UIScrollViewDelegate {
	
	let imgView = UIImageView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemYellow
		
		guard let img = UIImage(named: "beach") else { return }
		
		imgView.image = img
		
		let scrollView = UIScrollView()
		scrollView.backgroundColor = .red
		scrollView.delegate = self
		
		imgView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(scrollView)
		scrollView.addSubview(imgView)
		
		let g = view.safeAreaLayoutGuide
		let cg = scrollView.contentLayoutGuide
		let fg = scrollView.frameLayoutGuide
		
		NSLayoutConstraint.activate([
			
			scrollView.topAnchor.constraint(equalTo: g.topAnchor, constant: 20.0),
			scrollView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
			scrollView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),
			scrollView.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: -20.0),
			
			imgView.topAnchor.constraint(equalTo: cg.topAnchor, constant: 0.0),
			imgView.leadingAnchor.constraint(equalTo: cg.leadingAnchor, constant: 0.0),
			imgView.trailingAnchor.constraint(equalTo: cg.trailingAnchor, constant: 0.0),
			imgView.bottomAnchor.constraint(equalTo: cg.bottomAnchor, constant: 0.0),
			
			imgView.widthAnchor.constraint(equalTo: fg.widthAnchor),
			imgView.heightAnchor.constraint(equalTo: imgView.widthAnchor, multiplier: img.size.height / img.size.width)
			
		])
		
		scrollView.minimumZoomScale = 1.0
		scrollView.maximumZoomScale = 5.0
		
		// now let's add the grid "overlay"
		let gridView = GridOverlayView()
		gridView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(gridView)
		gridView.numRows = 4
		gridView.numColumns = 3
		gridView.lineColor = .black
		
		NSLayoutConstraint.activate([
			gridView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			gridView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
			gridView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
			gridView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
		])
		
		// don't let the grid overlay view interfere with the scrolling/zooming
		gridView.isUserInteractionEnabled = false
		
	}
	
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return imgView
	}
	
}

