//
//  FramesTableViewCell.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/1/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

class FramesTableViewCell: BaseTableViewCell, ConfigurableCell {

//MARK: Subview Initialization
    let numberLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = Theme.Color.yellow
        label.text = "1"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let aperature = FramesLabelWithImage()
    let shutterSpeed = FramesLabelWithImage()
    let date = FramesLabelWithImage()

    lazy var allAtributesStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [aperature.attributeStackView,shutterSpeed.attributeStackView,date.attributeStackView])
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    override func setupViews() {
        
        self.accessoryType = .disclosureIndicator
        
        addSubview(numberLabel)
        addSubview(allAtributesStackView)
        
        numberLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        numberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        numberLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        numberLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        
        allAtributesStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        allAtributesStackView.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 10).isActive = true
        allAtributesStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        allAtributesStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true

        
    }
    
    //MARK: ConfigurableCell Protocol Methods
    func configure(data frames: Frames) {
        aperature.attributeImage.image = frames.icon
        aperature.atributeLabel.text = frames.labelText
        
        shutterSpeed.attributeImage.image = frames.icon
        shutterSpeed.atributeLabel.text = frames.labelText
        
        date.attributeImage.image = frames.icon
        date.atributeLabel.text = frames.labelText

    }
    
    
}
