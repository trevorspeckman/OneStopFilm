//
//  IndicatorTableViewCell.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/12/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

class IndicatorTableViewCell : LabelWithImageTableViewCell  {
    
    //MARK: Subview Initialization
    
    let colorIndicator: SwiftDisclosureIndicator = {
        let indicator = SwiftDisclosureIndicator()
        indicator.color = ActiveRollTheme.current.colorOne
        indicator.backgroundColor = .clear
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    
    
    
    
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(colorIndicator)
        
        colorIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        colorIndicator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        colorIndicator.widthAnchor.constraint(equalToConstant: 20).isActive = true
        colorIndicator.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
