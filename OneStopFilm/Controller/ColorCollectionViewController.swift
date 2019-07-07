//
//  ColorCollectionViewController.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 6/27/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit


class ColorCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let colors: [UIColor] = [Theme.Color.red, Theme.Color.orange, Theme.Color.yellow, Theme.Color.green, Theme.Color.blue, Theme.Color.magenta, Theme.Color.purple]
    
    let lightColors: [UIColor] = [Theme.Color.lightRed, Theme.Color.lightOrange, Theme.Color.lightYellow, Theme.Color.lightGreen, Theme.Color.lightBlue, Theme.Color.lightMagenta, Theme.Color.lightPurple]
    
    var selectedParentViewCellIndex = 0
    var delegate: ChildViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "COLOR"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Theme.Font.titleFont!]

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
        // Do any additional setup after loading the view.
       collectionView.backgroundColor = Theme.Color.background
        
    }



    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 6
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath)

        cell.setGradientBackground(colorOne: colors[indexPath.row], colorTwo: lightColors[indexPath.row], locations: [0.0,1.0], startPoint: CGPoint(x: 0.0, y: 0.0), endPoint: CGPoint(x: 1.0, y: 1.0))
        return cell
    }

    //MARK: DelegateFlowLayout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width/3)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.childViewControllerResponse(response: [colors[indexPath.row],lightColors[indexPath.row]], selectedParentViewCellIndex: selectedParentViewCellIndex)
        navigationController?.popViewController(animated: true)
    }

}
