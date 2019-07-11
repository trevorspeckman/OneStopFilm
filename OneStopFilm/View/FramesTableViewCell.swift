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
    
    let aperature = LabelWithImageView()
    let shutterSpeed = LabelWithImageView()
    let date = LabelWithImageView()
    
    let colorIndicator: SwiftDisclosureIndicator = {
        let indicator = SwiftDisclosureIndicator()
        indicator.color = Theme.Color.yellow
        indicator.backgroundColor = .clear
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    lazy var allAtributesStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [aperature,shutterSpeed,date])
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    override func setupViews() {
        
        //self.accessoryType = .disclosureIndicator
        
        addSubview(numberLabel)
        addSubview(allAtributesStackView)
        addSubview(colorIndicator)
        
        

        numberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        numberLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        numberLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        numberLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        


        allAtributesStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        allAtributesStackView.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 10).isActive = true
        allAtributesStackView.trailingAnchor.constraint(equalTo: colorIndicator.leadingAnchor, constant: -10).isActive = true
        
        
        
        colorIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        colorIndicator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        colorIndicator.widthAnchor.constraint(equalToConstant: 20).isActive = true
        colorIndicator.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    //MARK: ConfigurableCell Protocol Methods
    func configure(data frames: LabelWithImage) {
        aperature.titleIcon.image = frames.icon
        aperature.titleLabel.text = frames.labelText
        
        shutterSpeed.titleIcon.image = frames.icon
        shutterSpeed.titleLabel.text = frames.labelText
        
        date.titleIcon.image = frames.icon
        date.titleLabel.text = frames.labelText

    }
    
    
}
