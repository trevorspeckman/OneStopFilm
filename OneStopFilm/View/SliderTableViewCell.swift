//
//  SliderTableViewCell.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/2/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

class SliderTableViewCell: LabelWithImageTableViewCell, ConfigurableCell  {
    
//MARK: Subview Initialization
    
    let cellSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1.4
        slider.maximumValue = 22
        let newValue = Int(slider.value/15) * 15
        slider.setValue(Float(newValue), animated: false)
        slider.minimumTrackTintColor = ActiveRollTheme.current.colorOne
        slider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    
    
   

    
    override func setupViews() {
        super.setupViews()
        
        addSubview(cellSlider)
        
        cellSlider.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        cellSlider.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10).isActive = true
         cellSlider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        cellSlider.heightAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true
        
        selectionStyle = .none
    }
    
    @objc func sliderChanged(_ sender : UISlider) {
        titleLabel.titleLabel.text = "f/\(cellSlider.value)"
    }
    
//MARK: ConfigurableCell Protocol Methods
    func configure(data labelWithImage: LabelWithImage) {
        //titleLabel.titleLabel.text = labelWithImage.labelText
        titleLabel.titleIcon.image = labelWithImage.icon
    }
    
    
}
