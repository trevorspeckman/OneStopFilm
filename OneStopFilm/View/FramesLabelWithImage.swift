//
//  FramesLabelWithImage.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/1/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

class FramesLabelWithImage {
    let atributeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.green
        
        label.text = "f/1.4"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let attributeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_log")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var attributeStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [attributeImage,atributeLabel])
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
}
