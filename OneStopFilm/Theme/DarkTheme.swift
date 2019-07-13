//
//  DarkTheme.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/11/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit
import Mapbox

struct DarkTheme: ThemeProtocol {
    
    var mainFontName: String = "Avenir-Light"
    var textColor: UIColor = .white
    var subtitleTextColor: UIColor = .gray
    var placeholderColor: UIColor = .gray
    var tintColor: UIColor = .orange
     var deleteButtonColor: UIColor = Color.redLight
    var tabTintColor: UIColor = .black
    var popupColor: UIColor = Color.cellDarkMap
    var cellColor: UIColor = Color.backgroundDarkMap
    var backgroundColor: UIColor = Color.backgroundDarkMap
    var barStyle: UIBarStyle = .black
    var mapStyle: URL = MGLStyle.darkStyleURL
}
