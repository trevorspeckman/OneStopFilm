//
//  ViewController.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 6/19/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit
import CoreData

class ActiveFilmRollsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    
    
    var activeFilmRolls = [ActiveFilmRoll]() {
        didSet{
            if activeFilmRolls.count == 0 {
                isEditing = false
                navigationItem.leftBarButtonItem?.isEnabled = false
            } else {
                navigationItem.leftBarButtonItem?.isEnabled = true
            }
            
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupCollectionView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadItems()
        collectionView.reloadData()

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
        cell.delegate = self
        cell.activeFilmRoll = activeFilmRolls[indexPath.row]
            
        
        return cell
    }
    
    
    //MARK: Delete Items
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        navigationItem.rightBarButtonItem?.isEnabled = !editing
        collectionView.allowsSelection = !editing
        if let indexPaths = collectionView?.indexPathsForVisibleItems {
            for indexPath in indexPaths {
                if let cell = collectionView?.cellForItem(at: indexPath) as? ActiveFilmRollCell {
                    cell.isEditing = editing
                }
            }
        }
        

        
    }
    
    //MARK: DelegateFlowLayout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 40, height: 180)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let framesTableViewController = FramesTableViewController()
        
        if let colorName = activeFilmRolls[indexPath.row].colorName {
            if let filmColor = Color.gradientDictionary[colorName] {
                ActiveRollTheme.current = filmColor
            }

        }
        navigationController?.pushViewController(framesTableViewController, animated: true)
    }
    
    
    
    fileprivate func setupNavBar() {
        navigationItem.title = "ACTIVE ROLLS"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.current.textColor, NSAttributedString.Key.font: Theme.Font.titleFont!]
        self.navigationController?.navigationBar.tintColor = Theme.current.textColor
        self.navigationController?.navigationBar.barTintColor = Theme.current.cellColor
        self.navigationController?.navigationBar.barStyle = Theme.current.barStyle
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = Theme.current.backgroundColor
        collectionView.register(ActiveFilmRollCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0,right: 0)
    }
    
    
    //MARK: Model Manipulation Methods
    func saveItems() {
        
        do{
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
    }
    
    func loadItems(with request: NSFetchRequest<ActiveFilmRoll> = ActiveFilmRoll.fetchRequest()) {
        
        //request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        do {
            activeFilmRolls = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }

}


//MARK: ActiveFilmRollCellDelegate Methods
extension ActiveFilmRollsViewController: ActiveFilmRollCellDelegate {
    func delete(cell: ActiveFilmRollCell) {
        if let indexPath = collectionView?.indexPath(for: cell) {
            context.delete(activeFilmRolls[indexPath.row])
            saveItems()
            loadItems()
            collectionView.deleteItems(at: [indexPath])
        }
    }
    
    
}
