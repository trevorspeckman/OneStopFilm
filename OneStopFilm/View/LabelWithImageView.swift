//
//  FramesLabelWithImage.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/1/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

class LabelWithImageView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.green
        
        label.text = "f/1.4"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_log")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
//    lazy var attributeStackView: UIStackView = {
//        let stack = UIStackView(arrangedSubviews: [attributeImage,atributeLabel])
//        stack.distribution = .fillProportionally
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        return stack
//    }()
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(titleIcon)
        
        
        titleIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        titleIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleIcon.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8).isActive = true
        titleIcon.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8).isActive = true
        
        
        titleLabel.bottomAnchor.constraint(equalTo: titleIcon.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: titleIcon.trailingAnchor, constant: 4).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
