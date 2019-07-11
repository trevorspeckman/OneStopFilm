//
//  FilmRollCellCollectionViewCell.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 6/21/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

protocol ActiveFilmRollCellDelegate: class {
    func delete(cell: ActiveFilmRollCell)
}

class ActiveFilmRollCell: BaseCollectionViewCell {
    
    
    weak var delegate: ActiveFilmRollCellDelegate?
    
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
            filmLabel.titleLabel.text = "\(activeFilmRoll?.film ?? "?")"
            
            //cameraLabel
            cameraLabel.titleLabel.text = "\(activeFilmRoll?.camera ?? "")"
            
            //circularProggresBar
            if let currentFrame = activeFilmRoll?.completedFrames {
                if let frameCount = activeFilmRoll?.frameCount {
                    circularProgressBar.progressLabel.text = "\(currentFrame)/\(frameCount)"
                    circularProgressBar.progressAngle = CGFloat(currentFrame) / CGFloat(frameCount) * 2*CGFloat.pi
                }
            }
            
            //xButtonContainer
            xButtonContainer.isHidden = true
            
            
            //gradient color
            guard let colorName = activeFilmRoll?.colorName else {print("error: no colorName"); return}
            if let dictionaryName = Theme.Color.gradientDictionary[colorName] {
                let color1 = dictionaryName[0]
                let color2 = dictionaryName[1]
                gradient = Gradient(name: colorName, color1: color1, color2: color2)
            }

            
        }

    }
    
    var isEditing: Bool = false {
        didSet{
            xButtonContainer.isHidden = !isEditing
        }
    }
    
//MARK: Subview definitions
    let bottomCap: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topCap: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topOfRoll: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let filmColor: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Theme.Font.titleLabelFont!
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: LabelWithImageView = {
        let label = LabelWithImageView()
        label.titleLabel.font = Theme.Font.bodyLabelFont!
        label.titleLabel.textColor = UIColor.white
        label.viewColor = .white
        label.titleIcon.image = UIImage(named: "icon_date")?.withRenderingMode(.alwaysTemplate)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let filmLabel: LabelWithImageView = {
        let label = LabelWithImageView()
        label.titleLabel.font = Theme.Font.bodyLabelFont!
        label.titleLabel.textColor = UIColor.white
        label.viewColor = .white
        label.titleIcon.image = UIImage(named: "icon_film")?.withRenderingMode(.alwaysTemplate)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cameraLabel: LabelWithImageView = {
        let label = LabelWithImageView()
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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let xButtonContainer: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.Color.redLight
        view.layer.shadowRadius = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let xButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon_x")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func xButtonTapped() {
       delegate?.delete(cell: self)
    }
    
    
    
    
    
    //MARK: Setup constraints
    override func setupViews() {

        xButton.addTarget(self, action: #selector(xButtonTapped), for: .touchUpInside)
        
        addSubview(bottomCap)
        addSubview(topCap)
        addSubview(topOfRoll)
        addSubview(filmColor)
        addSubview(labelBackground)
        addSubview(titleLabel)
        addSubview(stackView)
        addSubview(circularProgressBar)
        addSubview(xButtonContainer)
        xButtonContainer.addSubview(xButton)
        
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
        
        //xbuttonContainer constraints
        xButtonContainer.centerYAnchor.constraint(equalTo: topCap.topAnchor, constant: 5).isActive = true
        xButtonContainer.centerXAnchor.constraint(equalTo: topCap.centerXAnchor).isActive = true
        xButtonContainer.widthAnchor.constraint(equalToConstant: 30).isActive = true
        xButtonContainer.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        //xButton constraints
        xButton.centerYAnchor.constraint(equalTo: xButtonContainer.centerYAnchor).isActive = true
        xButton.centerXAnchor.constraint(equalTo: xButtonContainer.centerXAnchor).isActive = true
        xButton.heightAnchor.constraint(equalTo: xButtonContainer.heightAnchor, multiplier: 0.5).isActive = true
        xButton.widthAnchor.constraint(equalTo: xButtonContainer.widthAnchor, multiplier: 0.5).isActive = true
        
        
        
        

    }
    
    var gradient = Gradient(name: "", color1: .clear, color2: .clear)
    
    //MARK: Setup gradients
    override func setupGradients() {
        bottomCap.setGradientBackground(colorOne: .black, colorTwo: Theme.Color.capGrey, locations: [0.5,1], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1))
        
        topCap.setGradientBackground(colorOne: .black, colorTwo: Theme.Color.capGrey, locations: [0.5,1], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1))
        
        topOfRoll.setGradientBackground(colorOne: .black, colorTwo: Theme.Color.capGrey, locations: [0.5,1], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1))
        
        filmColor.setGradientBackground(colorOne: gradient.color1, colorTwo: gradient.color2, locations: [0.0,1.0], startPoint: CGPoint(x: 0.0, y: 0.0), endPoint: CGPoint(x: 1.0, y: 1.0))
        
        labelBackground.setGradientBackground(colorOne: .black, colorTwo: Theme.Color.capGrey, locations: [0.0,1.0], startPoint: CGPoint(x: 0.0, y: 0.0), endPoint: CGPoint(x: 1.0, y: 1.0))

        
    }
    
    override func roundCorners() {
        
        let cornerRadius = xButtonContainer.bounds.width/2
        xButtonContainer.layer.cornerRadius = cornerRadius


        // corner radius
        xButtonContainer.layer.cornerRadius = cornerRadius
        

        
        // shadow
        xButtonContainer.layer.shadowColor = UIColor.black.cgColor
        xButtonContainer.layer.shadowOffset = CGSize(width: -3, height: 3)
        xButtonContainer.layer.shadowOpacity = 0.7
        xButtonContainer.layer.shadowRadius = 4.0
    }
    
}
