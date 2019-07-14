//
//  ActiveFilmRollViewModel.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/13/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit


struct ActiveFilmRollViewModel {
    
    let titleLabelText: String
    let dateLabelText: String
    let filmLabelText: String
    let cameraLabelText: String
    let progressBarText: String
    let progressBarStroke: CGFloat
    let colorName: String
    
    init(_ activeFilmRoll: ActiveFilmRoll) {
        
        self.titleLabelText = activeFilmRoll.title ?? ""
        
        
        if let date = activeFilmRoll.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            dateFormatter.setLocalizedDateFormatFromTemplate("MM/dd/yyyy")
            self.dateLabelText = dateFormatter.string(from: date)
        } else {
            self.dateLabelText = ""
        }
        
        
        self.filmLabelText = "\(activeFilmRoll.film ?? "")"
        self.cameraLabelText = "\(activeFilmRoll.camera ?? "")"

       
        
        self.progressBarText = "\(activeFilmRoll.completedFrames)/\(activeFilmRoll.frameCount)"
        self.progressBarStroke = CGFloat(activeFilmRoll.completedFrames) / CGFloat(activeFilmRoll.frameCount) * 2*CGFloat.pi
        
        self.colorName = activeFilmRoll.colorName ?? "Black"

    }
    
    
    
}
