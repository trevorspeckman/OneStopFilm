//
//  Theme.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 6/21/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

struct Theme {
    
    static var current: ThemeProtocol = LightTheme()

    
    struct Font {
        static let titleFont = UIFont(name: "Avenir-Light", size: 17)
        static let titleLabelFont = UIFont(name: "Avenir-Light", size: 20)
        static let bodyLabelFont = UIFont(name: "Avenir-Light", size: 14)
        static let newRollTitleLabelFont = UIFont(name: "Avenir-Light", size: 10)
    }
    
    

}
