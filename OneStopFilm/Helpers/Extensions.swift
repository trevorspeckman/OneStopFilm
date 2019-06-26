//
//  Extensions.swift
//  youtubeClone
//
//  Created by Trevor Speckman on 6/20/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

//MARK: Simplify constraint code
extension UIView {
    func addContraintsWithFormat(format: String, views: UIView...) {
        
        var viewsDictionary = [String : UIView]()
        for (index,view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

//MARK: Allow for Hex color input
extension UIColor {
    convenience init(hexFromString:String, alpha:CGFloat = 1.0) {
        var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

//MARK: Add icon to UILabel
extension UILabel {
    func set(image: UIImage, with text: String, color: UIColor) {
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)

        let attachmentStr = NSAttributedString(attachment: attachment)
        
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(attachmentStr)
        
        let textString = NSAttributedString(string: " " + text, attributes: [.font: self.font!])
        mutableAttributedString.append(textString)
        
        self.attributedText = mutableAttributedString
        self.textColor = color
        
    }
}

//MARK: Add gradient backgrounds

extension UIView {
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor, locations: [NSNumber], startPoint: CGPoint, endPoint: CGPoint) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = locations
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        
        layer.insertSublayer(
            gradientLayer, at: 0)
    }
}
