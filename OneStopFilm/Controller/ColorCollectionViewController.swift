//
//  ColorCollectionViewController.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 6/27/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit


class ColorCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var colors = [Gradient]()
    
    
    var selectedParentViewCellIndex = 0
    
    var delegate: ChildViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "COLOR"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Theme.Font.titleFont!]

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
        // Do any additional setup after loading the view.
       collectionView.backgroundColor = Theme.current.backgroundColor
        
        createGradients()
    }



    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return colors.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath)

        cell.setGradientBackground(colorOne: colors[indexPath.row].color1, colorTwo: colors[indexPath.row].color2, locations: [0.0,1.0], startPoint: CGPoint(x: 0.0, y: 0.0), endPoint: CGPoint(x: 1.0, y: 1.0))
        return cell
    }

    //MARK: DelegateFlowLayout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width/3)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.childViewControllerResponse(response: colors[indexPath.row], selectedParentViewCellIndex: selectedParentViewCellIndex)
        navigationController?.popViewController(animated: true)
    }
    
    func createGradients() {
        let blackGrdient = Gradient(name: "black", color1: Color.black, color2: Color.blackLight)
        let redGradient = Gradient(name: "red", color1: Color.red, color2: Color.redLight)
        let orangeGradient = Gradient(name: "orange", color1: Color.orange, color2: Color.orangeLight)
        let yellowGradient = Gradient(name: "yellow", color1: Color.yellow, color2: Color.yellowLight)
        let greenGradient = Gradient(name: "green", color1:Color.green, color2: Color.greenLight)
        let blueGradient = Gradient(name: "blue", color1: Color.blue, color2: Color.blueLight)
        let purpleGradient = Gradient(name: "purple", color1: Color.purple, color2: Color.purpleLight)
        
        colors = [blackGrdient, redGradient,orangeGradient,yellowGradient,greenGradient,blueGradient, purpleGradient]
    }

}
