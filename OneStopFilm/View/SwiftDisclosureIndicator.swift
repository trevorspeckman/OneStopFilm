//
//  SwiftDisclosureIndicator.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/2/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//


import UIKit
class SwiftDisclosureIndicator: UIView {
    @IBInspectable var color = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        let x = self.bounds.maxX - 3
        let y = self.bounds.midY
        let R = CGFloat(4.5)
        context?.move(to: CGPoint(x: x - R, y: y - R))
        context?.addLine(to: CGPoint(x: x, y: y))
        context?.addLine(to: CGPoint(x: x - R, y: y + R))
        context?.setLineCap(.square)
        context?.setLineJoin(.miter)
        context?.setLineWidth(2)
        color.setStroke()
        context?.strokePath()
    }
}
