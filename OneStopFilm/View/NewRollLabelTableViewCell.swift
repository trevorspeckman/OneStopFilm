//
//  LabelTableViewCell.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 6/27/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit



class NewRollLabelTableViewCell: BaseTableViewCell, ConfigurableCell {

    
    var value: String? {
        return selectionLabel.text
    }
    
    
    
//MARK: Subview Initialization
    let titleLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.red
        label.text = "FILM"
        label.textColor = Theme.current.textColor
        label.alpha = 0
        label.font = Theme.Font.newRollTitleLabelFont!
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let selectionLabel: UILabel = {
        let label = UILabel()
        //textField.backgroundColor = UIColor.green
        let placeholder = "FILM"
        label.text = placeholder
        label.textColor = Theme.current.placeholderColor
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func setupViews() {

        self.accessoryType = .disclosureIndicator
        
        addSubview(titleLabel)
        addSubview(selectionLabel)
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        
        selectionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        selectionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        selectionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        selectionLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        //selectionStyle = .none

        
    }
    
//MARK: ConfigurableCell Protocol Methods
    func configure(data labelText: String) {
        titleLabel.text = labelText
        selectionLabel.text = labelText
    }
    
    

}
