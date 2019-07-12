//
//  BasePopUp.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/1/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

class BasePopup: UIView {
    
    let saveButton: UIButton = {
        let button = UIButton()
        //button.backgroundColor = .blue
        button.setTitle("Add", for: .normal)
        button.isEnabled = false
        button.setTitleColor(Theme.current.placeholderColor, for: .normal)
        button.layer.masksToBounds = true
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        // button.backgroundColor = .yellow
        button.setTitleColor(Theme.current.textColor, for: .normal)
        button.setTitle("Cancel", for: .normal)

        
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
        view.backgroundColor = Theme.current.popupColor
        view.layer.cornerRadius = 15
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
