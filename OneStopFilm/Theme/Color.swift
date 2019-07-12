//
//  Color.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/11/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

struct Color {
    static let backgroundLight = UIColor(hexFromString: "EEEEEE")
    static let backgroundDark = UIColor(hexFromString: "15202a")
    static let cellDark = UIColor(hexFromString: "1b2837")
    static let black = UIColor(hexFromString: "000000")
    static let blackLight = UIColor(hexFromString: "8D8D8D")
    static let labelBackground = UIColor(hexFromString: "343434")
    static let green = UIColor(hexFromString: "01A13A")
    static let greenLight = UIColor(hexFromString: "54D683")
    static let yellow = UIColor(hexFromString: "FDBA20")
    static let yellowLight = UIColor(hexFromString: "FFE19C")
    static let red = UIColor(hexFromString: "eb1c27")
    static let redLight = UIColor(hexFromString: "FF767D")
    static let redDark = UIColor(hexFromString: "391A1B")
    static let blue = UIColor(hexFromString: "464892")
    static let blueLight = UIColor(hexFromString: "8E91FF")
    static let purple = UIColor(hexFromString: "6F0064")
    static let purpleLight = UIColor(hexFromString: "c492bf")
    static let orange = UIColor(hexFromString: "FB6522")
    static let orangeLight = UIColor(hexFromString: "FFA05E")
    static let capGrey = UIColor(hexFromString: "363636")
    static let translucentWhite = UIColor(hexFromString: "FFFFFF").withAlphaComponent(0.7)
    
    static var gradientDictionary = [
        "black" : [Color.black, Color.blackLight],
        "red" : [Color.red, Color.redLight],
        "orange" : [Color.orange, Color.orangeLight],
        "yellow" : [Color.yellow, Color.yellowLight],
        "green" : [Color.green, Color.greenLight],
        "blue" : [Color.blue, Color.blueLight],
        "purple" : [Color.purple, Color.purpleLight]
    ]
    
}
