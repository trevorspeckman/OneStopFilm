//
//  SelfSizedTableView.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/3/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

class SelfSizedTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
