//
//  BasePopUp.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/1/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

class BasePopUp: UIView {
    
    let saveButton: UIButton = {
        let button = UIButton()
        //button.backgroundColor = .blue
        button.setTitle("Add Film", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.masksToBounds = true
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        // button.backgroundColor = .yellow
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cancelButton,saveButton])
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    func setupViews() {
        addSubview(container)
        
        container.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.35).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
