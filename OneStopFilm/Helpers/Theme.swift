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
        static let lightGreen = UIColor(hexFromString: "54D683")
        static let yellow = UIColor(hexFromString: "FDBA20")
        static let lightYellow = UIColor(hexFromString: "FFE19C")
        static let red = UIColor(hexFromString: "eb1c27")
        static let lightRed = UIColor(hexFromString: "FF767D")
        static let blue = UIColor(hexFromString: "464892")
        static let lightBlue = UIColor(hexFromString: "8E91FF")
        static let magenta = UIColor(hexFromString: "922579")
        static let lightMagenta = UIColor(hexFromString: "FF7AE0")
        static let purple = UIColor(hexFromString: "6F0064")
        static let lightPurple = UIColor(hexFromString: "c492bf")
        static let orange = UIColor(hexFromString: "FB6522")
        static let lightOrange = UIColor(hexFromString: "FFA05E")
        static let capGrey = UIColor(hexFromString: "363636")
        static let translucentWhite = UIColor(hexFromString: "FFFFFF").withAlphaComponent(0.9)
        
    }
    

    
    struct Font {
        static let titleFont = UIFont(name: "Avenir-Light", size: 17)
        static let titleLabelFont = UIFont(name: "Avenir-Light", size: 20)
        static let bodyLabelFont = UIFont(name: "Avenir-Light", size: 14)
        static let newRollTitleLabelFont = UIFont(name: "Avenir-Light", size: 10)
    }
}
