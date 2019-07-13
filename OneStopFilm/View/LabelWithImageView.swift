//
//  FramesLabelWithImage.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/1/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

class LabelWithImageView: UIView {
    
    var viewColor: UIColor {
        didSet{
            titleLabel.textColor = viewColor
            titleIcon.tintColor = viewColor

        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()

        
        label.text = "-"
        label.textAlignment = .left
        label.font = Theme.Font.titleLabelFont!

        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    

    private func setupViews() {
        addSubview(titleLabel)
        addSubview(titleIcon)
        
        
        titleIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        titleIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleIcon.widthAnchor.constraint(equalTo: titleLabel.heightAnchor, multiplier: 0.8).isActive = true
        titleIcon.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, multiplier: 0.8).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: titleIcon.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: titleIcon.trailingAnchor, constant: 4).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        
        
        
    }
    
    override init(frame: CGRect) {
        viewColor = .black
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
