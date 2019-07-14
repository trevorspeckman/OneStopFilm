//
//  BaseNoDataView.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/13/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

class BaseNoDataView: UIView {
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        backgroundColor = Theme.current.backgroundColor
        setupViews()
    }
    
    let imageContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = Theme.current.textColor
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    let topLabel: UILabel = {
        let label = UILabel()
        label.font = Theme.Font.titleLabelFont!
        label.textColor = Theme.current.textColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bottomLabel: UILabel = {
        let label = UILabel()
        label.font = Theme.Font.bodyLabelFont!
        label.textColor = Theme.current.subtitleTextColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    
    func setupViews() {

        addSubview(imageContainerView)
        addSubview(topLabel)
        addSubview(bottomLabel)
        imageContainerView.addSubview(imageView)
        
        imageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
        imageView.centerYAnchor.constraint(equalTo: imageContainerView.safeAreaLayoutGuide.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageContainerView.heightAnchor, multiplier: 0.3).isActive = true
        
        topLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        topLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        topLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
        bottomLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 10).isActive = true
        bottomLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        bottomLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
        
    }
    
    
    init(imageName: String, Title: String, Body: String){
        super .init(frame: UIScreen.main.bounds)
        setupViews()
        backgroundColor = Theme.current.backgroundColor
        imageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        topLabel.text = Title
        bottomLabel.text = Body
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
