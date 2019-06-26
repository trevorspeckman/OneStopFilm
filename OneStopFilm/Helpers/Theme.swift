//
//  Theme.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 6/21/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

struct Theme {
    struct Color {
        static let background = UIColor(hexFromString: "EEEEEE")
        static let labelBackground = UIColor(hexFromString: "343434")
        static let green = UIColor(hexFromString: "01A13A")
        static let yellow = UIColor(hexFromString: "FDBA20")
        static let capGrey = UIColor(hexFromString: "363636")
        static let lightyellow = UIColor(hexFromString: "EAD73D")
        static let translucentWhite = UIColor(hexFromString: "FFFFFF").withAlphaComponent(0.9)
        
    }
    

    
    struct Font {
        static let titleFont = UIFont(name: "Avenir-Light", size: 17)
        static let titleLabelFont = UIFont(name: "Avenir-Light", size: 20)
        static let bodyLabelFont = UIFont(name: "Avenir-Light", size: 14)
    }
}
