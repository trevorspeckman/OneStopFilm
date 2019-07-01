//
//  ViewController.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 6/19/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit


class CurrentRollsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup navigation bar
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.title = "CURRENT ROLLS"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Theme.Font.titleFont!]
 
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))

        //setup Collection View
        collectionView.backgroundColor = Theme.Color.background
        collectionView.register(FilmRollCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0,right: 0)
 
    }
    
    @objc func addTapped() {
        let addNewRollTableViewController = NewRollTableViewController()
        let addNewRollNavController = UINavigationController(rootViewController: addNewRollTableViewController)
        self.present(addNewRollNavController, animated: true, completion: nil)
        
    }
    
    //MARK: DataSource Methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        
        return cell
    }
    
    //MARK: DelegateFlowLayout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 40, height: 180)
    }

}

