//
//  BaseCell.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 6/21/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupGradients()
    }
    
    func setupViews() {
        
    }
    
    func setupGradients() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
