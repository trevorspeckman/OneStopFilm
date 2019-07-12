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
        label.text = "1"
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let numberLabelContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        
        addSubview(numberLabelContainer)
        numberLabelContainer.addSubview(numberLabel)
        addSubview(aperatureLabel)
        addSubview(shutterSpeedLabel)
        addSubview(dateLabel)
        addSubview(colorIndicator)
        
        

        numberLabelContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        numberLabelContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        numberLabelContainer.widthAnchor.constraint(equalToConstant: 35).isActive = true
        numberLabelContainer.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        
        numberLabel.centerXAnchor.constraint(equalTo: numberLabelContainer.centerXAnchor).isActive = true
        numberLabel.centerYAnchor.constraint(equalTo: numberLabelContainer.centerYAnchor).isActive = true
        
        
        
        aperatureLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        aperatureLabel.leadingAnchor.constraint(equalTo: numberLabelContainer.trailingAnchor, constant: 10).isActive = true
        aperatureLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
        aperatureLabel.heightAnchor.constraint(equalTo: numberLabelContainer.heightAnchor).isActive = true
        
        
        shutterSpeedLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        shutterSpeedLabel.leadingAnchor.constraint(equalTo: aperatureLabel.trailingAnchor).isActive = true
         shutterSpeedLabel.widthAnchor.constraint(equalTo: aperatureLabel.widthAnchor).isActive = true
        shutterSpeedLabel.heightAnchor.constraint(equalTo: numberLabelContainer.heightAnchor).isActive = true
        
        
        
        dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: shutterSpeedLabel.trailingAnchor).isActive = true
        dateLabel.widthAnchor.constraint(equalTo: aperatureLabel.widthAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalTo: numberLabelContainer.heightAnchor).isActive = true
        
        
        colorIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        colorIndicator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        colorIndicator.widthAnchor.constraint(equalToConstant: 20).isActive = true
        colorIndicator.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        
        numberLabelContainer.setGradientBackground(colorOne: ActiveRollTheme.current.colorOne, colorTwo: ActiveRollTheme.current.colorTwo, locations: [0.5,1], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1))
        
    }
    
   
    
    
}
