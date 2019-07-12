//
//  FramesTableViewCell.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/1/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

class FramesTableViewCell: BaseTableViewCell {

    
    
//MARK: Subview Initialization
    let numberLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = ActiveRollTheme.current.colorOne
        label.text = "1"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let aperatureLabel: LabelWithImageView = {
        let label = LabelWithImageView()

        label.titleLabel.text = "f/-.-"
        label.titleLabel.font = Theme.Font.bodyLabelFont!
        label.titleLabel.textColor = UIColor.white
        label.viewColor = Theme.current.textColor
        label.titleIcon.image = UIImage(named: "icon_film")?.withRenderingMode(.alwaysTemplate)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let shutterSpeedLabel: LabelWithImageView = {
        let label = LabelWithImageView()
        label.titleLabel.text = "1/----"
        label.titleLabel.font = Theme.Font.bodyLabelFont!
        label.titleLabel.textColor = UIColor.white
        label.viewColor = Theme.current.textColor
        label.titleIcon.image = UIImage(named: "icon_film")?.withRenderingMode(.alwaysTemplate)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: LabelWithImageView = {
        let label = LabelWithImageView()
        label.titleLabel.text = "--/--/----"
        label.titleLabel.font = Theme.Font.bodyLabelFont!
        label.titleLabel.textColor = UIColor.white
        label.viewColor = Theme.current.textColor
        label.titleIcon.image = UIImage(named: "icon_date")?.withRenderingMode(.alwaysTemplate)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    let colorIndicator: SwiftDisclosureIndicator = {
        let indicator = SwiftDisclosureIndicator()
        indicator.color = ActiveRollTheme.current.colorOne
        indicator.backgroundColor = .clear
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    
    
    
    override func setupViews() {
        
        //self.accessoryType = .disclosureIndicator
        
        addSubview(numberLabel)
        addSubview(aperatureLabel)
        addSubview(shutterSpeedLabel)
        addSubview(dateLabel)
        addSubview(colorIndicator)
        
        

        numberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        numberLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        numberLabel.widthAnchor.constraint(equalToConstant: 35).isActive = true
        numberLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        
        aperatureLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        aperatureLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 10).isActive = true
        aperatureLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
        aperatureLabel.heightAnchor.constraint(equalTo: numberLabel.heightAnchor).isActive = true
        
        
        shutterSpeedLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        shutterSpeedLabel.leadingAnchor.constraint(equalTo: aperatureLabel.trailingAnchor).isActive = true
         shutterSpeedLabel.widthAnchor.constraint(equalTo: aperatureLabel.widthAnchor).isActive = true
        shutterSpeedLabel.heightAnchor.constraint(equalTo: numberLabel.heightAnchor).isActive = true
        
        
        
        dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: shutterSpeedLabel.trailingAnchor).isActive = true
        dateLabel.widthAnchor.constraint(equalTo: aperatureLabel.widthAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalTo: numberLabel.heightAnchor).isActive = true
        
        
        colorIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        colorIndicator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        colorIndicator.widthAnchor.constraint(equalToConstant: 20).isActive = true
        colorIndicator.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
   
    
    
}
