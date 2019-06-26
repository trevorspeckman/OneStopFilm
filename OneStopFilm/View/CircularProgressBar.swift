//
//  CircularProgressBar.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 6/25/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

class CircularProgressBar: UIView {
    
    let progressLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.green
        label.text = "14/24"
        label.font = Theme.Font.bodyLabelFont!
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    let shapeLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupProgressBarLayers()
    }
    
    
    func setupProgressBarLayers() {
        let linewidth: CGFloat = 5
        let center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        let radius = (self.bounds.width / 2 - linewidth/2)
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle:  -CGFloat.pi / 2, endAngle: 2*CGFloat.pi, clockwise: true)
        let progressPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: CGFloat.pi, clockwise: true)
        
        shapeLayer.path = progressPath.cgPath
        shapeLayer.strokeColor = Theme.Color.yellow.cgColor
        shapeLayer.lineWidth = linewidth
        //shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.gray.cgColor
        trackLayer.lineWidth = linewidth
        trackLayer.fillColor = Theme.Color.background.cgColor
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 1
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "progress")
    }
    

    func setupViews() {
        self.layer.addSublayer(trackLayer)
        self.layer.addSublayer(shapeLayer)
        
        self.addSubview(progressLabel)
        
        progressLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        progressLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        progressLabel.heightAnchor.constraint(equalToConstant: 16)
    }
    
    
}
