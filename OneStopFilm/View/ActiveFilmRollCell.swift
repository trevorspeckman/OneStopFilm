//
//  FilmRollCellCollectionViewCell.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 6/21/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit


class FilmStock {
    var brand: String?
    var name: String?
}

class Camera {
    var brand: String?
    var name: String?
}

class Lens {
    var brand: String?
    var name: String?
    var focalLength: String?
    var minAperature: Float?
    var maxAperature: Float?
}

class Icons {
    var brand: String?
    var name: String?
}

class ActiveFilmRoll {
    var title: String?
    var filmStock: FilmStock?
    var filmSpeed: Int?
    var frameCount: Int?
    var completedFrames: Int?
    var camera: Camera?
    var color: String?
    var date: Date?
}

class ActiveFilmRollCell: BaseCollectionViewCell {
    
//MARK: Fill Cell from Model
    var activeFilmRoll: ActiveFilmRoll? {
        didSet{
            //titleLabel
            titleLabel.text = activeFilmRoll?.title
            
            //dateLabel
            if let date = activeFilmRoll?.date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .none
                dateFormatter.setLocalizedDateFormatFromTemplate("MM/dd/yyyy")
                dateLabel.titleLabel.text = dateFormatter.string(from: date)
            }
            
            //filmLabel
            filmLabel.titleLabel.text = "\(activeFilmRoll?.filmStock?.brand ?? "?") \(activeFilmRoll?.filmStock?.name ?? "?")"
            
            //cameraLabel
            cameraLabel.titleLabel.text = "\(activeFilmRoll?.camera?.brand ?? "") \(activeFilmRoll?.camera?.name ?? "")"
            
            //circularProggresBar
            if let currentFrame = activeFilmRoll?.completedFrames {
                if let frameCount = activeFilmRoll?.frameCount {
                    circularProgressBar.progressLabel.text = "\(currentFrame)/\(frameCount)"
                    circularProgressBar.progressAngle = CGFloat(currentFrame) / CGFloat(frameCount) * 2*CGFloat.pi
                }
            }

        }
    }
    
    
//MARK: Subview definitions
    let bottomCap: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topCap: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topOfRoll: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let filmColor: UIView = {
        let view = UIView()
        //view.backgroundColor = Theme.Color.yellow

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelBackground: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.Color.labelBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.green
        //label.text = "TRIP TO YOSEMITE"
        label.font = Theme.Font.titleLabelFont!
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: LabelWithImageView = {
        let label = LabelWithImageView()
//        label.backgroundColor = UIColor.green
        
        label.titleLabel.font = Theme.Font.bodyLabelFont!
        label.titleLabel.textColor = UIColor.white
        label.viewColor = .white
        label.titleIcon.image = UIImage(named: "icon_date")?.withRenderingMode(.alwaysTemplate)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let filmLabel: LabelWithImageView = {
        let label = LabelWithImageView()
//        label.backgroundColor = UIColor.blue
        label.titleLabel.font = Theme.Font.bodyLabelFont!
        label.titleLabel.textColor = UIColor.white
        label.viewColor = .white
        label.titleIcon.image = UIImage(named: "icon_film")?.withRenderingMode(.alwaysTemplate)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cameraLabel: LabelWithImageView = {
        let label = LabelWithImageView()
//        label.backgroundColor = UIColor.red
        label.titleLabel.font = Theme.Font.bodyLabelFont!
        label.titleLabel.textColor = UIColor.white
        label.viewColor = .white
        label.titleIcon.image = UIImage(named: "icon_camera")?.withRenderingMode(.alwaysTemplate)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    fileprivate lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [dateLabel,filmLabel,cameraLabel])
        stack.axis = NSLayoutConstraint.Axis.vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    

    
    let circularProgressBar: CircularProgressBar = {
        let view =  CircularProgressBar()
        //view.backgroundColor = UIColor.green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    
    
    
    
    //MARK: Setup constraints
    override func setupViews() {

        addSubview(bottomCap)
        addSubview(topCap)
        addSubview(topOfRoll)
        addSubview(filmColor)
        addSubview(labelBackground)
        addSubview(titleLabel)
        addSubview(stackView)
        
        addSubview(circularProgressBar)
        
        //bottomCap constraints
        bottomCap.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bottomCap.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomCap.widthAnchor.constraint(equalToConstant: 12).isActive = true
        bottomCap.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        //topOfROll constraints
        topOfRoll.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topOfRoll.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        topOfRoll.widthAnchor.constraint(equalToConstant: 18).isActive = true
        topOfRoll.heightAnchor.constraint(equalToConstant: 84).isActive = true
        
        //topCap constraints
        topCap.trailingAnchor.constraint(equalTo: topOfRoll.leadingAnchor).isActive = true
        topCap.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        topCap.widthAnchor.constraint(equalToConstant: 12).isActive = true
        topCap.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        //filmcolor constraints
        filmColor.leadingAnchor.constraint(equalTo: bottomCap.trailingAnchor).isActive = true
        filmColor.trailingAnchor.constraint(equalTo: topCap.leadingAnchor).isActive = true
        filmColor.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        filmColor.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true

        //labelBackground constraints
        labelBackground.leadingAnchor.constraint(equalTo: bottomCap.trailingAnchor).isActive = true
        labelBackground.trailingAnchor.constraint(equalTo: topCap.leadingAnchor).isActive = true
        labelBackground.topAnchor.constraint(equalTo: topAnchor, constant: 63).isActive = true
        labelBackground.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true

        
        //titleLabel constraints
        titleLabel.leadingAnchor.constraint(equalTo: labelBackground.leadingAnchor,constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: labelBackground.trailingAnchor,constant: -10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: labelBackground.topAnchor,constant: 10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        //stackView constraints
        stackView.leadingAnchor.constraint(equalTo: labelBackground.leadingAnchor,constant: 10).isActive = true
            stackView.trailingAnchor.constraint(equalTo: circularProgressBar.leadingAnchor,constant: -10).isActive = true
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
            stackView.bottomAnchor.constraint(equalTo: labelBackground.bottomAnchor,constant: -10 ).isActive = true
        
        //progressRingContainer constraints
        circularProgressBar.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        circularProgressBar.trailingAnchor.constraint(equalTo: labelBackground.trailingAnchor,constant: -16).isActive = true
        circularProgressBar.heightAnchor.constraint(equalToConstant: 58).isActive = true
        circularProgressBar.widthAnchor.constraint(equalToConstant: 58).isActive = true
        

    }
    
    
    
    //MARK: Setup gradients
    override func setupGradients() {
        bottomCap.setGradientBackground(colorOne: .black, colorTwo: Theme.Color.capGrey, locations: [0.5,1], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1))
        
        topCap.setGradientBackground(colorOne: .black, colorTwo: Theme.Color.capGrey, locations: [0.5,1], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1))
        
        topOfRoll.setGradientBackground(colorOne: .black, colorTwo: Theme.Color.capGrey, locations: [0.5,1], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1))
        
        filmColor.setGradientBackground(colorOne: Theme.Color.yellow, colorTwo: Theme.Color.lightyellow, locations: [0.0,1.0], startPoint: CGPoint(x: 0.0, y: 0.0), endPoint: CGPoint(x: 1.0, y: 1.0))
        
        labelBackground.setGradientBackground(colorOne: .black, colorTwo: Theme.Color.capGrey, locations: [0.0,1.0], startPoint: CGPoint(x: 0.0, y: 0.0), endPoint: CGPoint(x: 1.0, y: 1.0))

        
    }
}
