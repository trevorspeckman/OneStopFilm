//
//  ViewController.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 6/19/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit


class ActiveFilmRollsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    
    var activeFilmRolls = [ActiveFilmRoll]()
    
    func setupData() {
        let camera = Camera()
        camera.brand = "Pentax"
        camera.name = "K1000"
        
        let film = FilmStock()
        film.brand = "Kodak"
        film.name = "Portra"
        
        let activeFilmRoll = ActiveFilmRoll()
        activeFilmRoll.title = "TRIP TO YOSEMITE"
        activeFilmRoll.filmStock = film
        activeFilmRoll.filmSpeed = 400
        activeFilmRoll.frameCount = 24
        activeFilmRoll.completedFrames = 1
        activeFilmRoll.camera = camera
        activeFilmRoll.color = "yellow"
        activeFilmRoll.date = Date()
        
        activeFilmRolls = [activeFilmRoll]
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup navigation bar
        navigationItem.title = "CURRENT ROLLS"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: Theme.Font.titleFont!]
        self.navigationController?.navigationBar.tintColor = .black
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))


        
        //setup Collection View
        collectionView.backgroundColor = Theme.Color.background
        collectionView.register(ActiveFilmRollCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0,right: 0)
        
        setupData()
    }
    
    

    
    @objc func addTapped() {
        let addNewRollTableViewController = NewRollTableViewController()
        let addNewRollNavController = UINavigationController(rootViewController: addNewRollTableViewController)
        self.present(addNewRollNavController, animated: true, completion: nil)
        
    }
    
    //MARK: DataSource Methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activeFilmRolls.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ActiveFilmRollCell
        
        cell.layer.shouldRasterize = true;
        cell.layer.rasterizationScale = UIScreen.main.scale
        
        cell.activeFilmRoll = activeFilmRolls[indexPath.row]
            
        
        return cell
    }
    
    //MARK: DelegateFlowLayout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 40, height: 180)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let framesTableViewController = FramesTableViewController()
        navigationController?.pushViewController(framesTableViewController, animated: true)
    }

}

