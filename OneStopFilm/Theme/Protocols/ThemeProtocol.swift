//
//  ThemeProtocol.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/11/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit
import Mapbox

protocol ThemeProtocol {
    
    var mainFontName: String { get }
    var textColor: UIColor { get }
    var subtitleTextColor: UIColor { get }
    var placeholderColor: UIColor { get }
    var tintColor: UIColor { get }
    var deleteButtonColor: UIColor { get }
    var tabTintColor: UIColor { get }
    var popupColor: UIColor { get }
    var cellColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var barStyle: UIBarStyle { get }
    var mapStyle: URL { get }
}
