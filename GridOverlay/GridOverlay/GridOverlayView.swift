//
//  GridOverlayView.swift
//  GridOverlay
//
//  Created by Don Mag on 11/2/22.
//

import UIKit

@IBDesignable
class GridOverlayView: UIView {
	
	@IBInspectable public var lineColor: UIColor = .white { didSet { setNeedsLayout() } }
	@IBInspectable public var numRows: Int = 1 { didSet { setNeedsLayout() } }
	@IBInspectable public var numColumns: Int = 1 { didSet { setNeedsLayout() } }
	
	private let gridLayer = CAShapeLayer()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		backgroundColor = .clear
	}
	func commonInit() {
		backgroundColor = .clear
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
