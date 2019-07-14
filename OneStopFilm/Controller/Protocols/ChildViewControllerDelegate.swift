//
//  ChildViewControllerDelegate.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/13/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import Foundation

protocol ChildViewControllerDelegate {
    func childViewControllerResponse(response: Any, selectedParentViewCellIndex: Int)
}
