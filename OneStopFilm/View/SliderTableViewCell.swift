//
//  SliderTableViewCell.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/2/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

class SliderTableViewCell: BaseTableViewCell, ConfigurableCell  {
    
//MARK: Subview Initialization
    
    let cellSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1.4
        slider.maximumValue = 22
        let newValue = Int(slider.value/15) * 15
        slider.setValue(Float(newValue), animated: false)
        slider.minimumTrackTintColor = Theme.Color.yellow
        slider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    let titleLabel: LabelWithImageView = {
        let view = LabelWithImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
   

    
    override func setupViews() {
        addSubview(titleLabel)
        addSubview(cellSlider)
        
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
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
