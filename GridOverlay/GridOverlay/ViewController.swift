//
//  ViewController.swift
//  GridOverlay
//
//  Created by Don Mag on 11/1/22.
//

import UIKit

class GridOverlayView: UIView {
	
	public var lineColor: UIColor = .white { didSet { setNeedsLayout() } }
	public var numRows: Int = 1 { didSet { setNeedsLayout() } }
	public var numColumns: Int = 1 { didSet { setNeedsLayout() } }
	
	private let gridLayer = CAShapeLayer()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	func commonInit() {
		layer.addSublayer(gridLayer)
		gridLayer.fillColor = UIColor.clear.cgColor
		gridLayer.lineWidth = 1
	}
	override func layoutSubviews() {
		super.layoutSubviews()
		
		if numRows == 1 && numColumns == 1 {
			// no need to draw any lines
			gridLayer.path = nil
			return
		}
		
		let bez = UIBezierPath()
		
		if numRows > 1 {
			let yIncrement: CGFloat = bounds.height / CGFloat(numRows)
			var y: CGFloat = yIncrement
			for _ in 0..<numRows-1 {
				bez.move(to: CGPoint(x: bounds.minX, y: y))
				bez.addLine(to: CGPoint(x: bounds.maxX, y: y))
				y += yIncrement
			}
		}
		
		if numColumns > 1 {
			let xIncrement: CGFloat = bounds.width / CGFloat(numColumns)
			var x: CGFloat = xIncrement
			for _ in 0..<numColumns-1 {
				bez.move(to: CGPoint(x: x, y: bounds.minY))
				bez.addLine(to: CGPoint(x: x, y: bounds.maxY))
				x += xIncrement
			}
		}
		
		gridLayer.strokeColor = lineColor.cgColor
		gridLayer.path = bez.cgPath
	}
}


class ViewController: UIViewController, UIScrollViewDelegate {
	
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

