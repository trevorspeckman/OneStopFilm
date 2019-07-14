//
//  ActiveFilmRollsViewController.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 6/19/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit
import CoreData

class ActiveFilmRollsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    
//MARK - Define Global Variables/Constants
    // Model
    var activeFilmRolls = [ActiveFilmRoll]() {
        didSet{
            if activeFilmRolls.count == 0 {
                noData = true
                isEditing = false
                navigationItem.leftBarButtonItem?.isEnabled = false
            } else {
                noData = false
                navigationItem.leftBarButtonItem?.isEnabled = true
            }
        }
    }
    
    // Context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // State
    var noData: Bool = false{
        didSet {
            noCellsView.isHidden = !noData
            collectionView.isHidden = noData
        }
    }
    
    // View when there are no cells
    let noCellsView = BaseNoDataView(imageName: "Background_add", Title: "NO ACTIVE ROLLS", Body: "ADD A ROLL BY TAPPING THE + BUTTON")

    
//MARK - View Controller Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupCollectionView()
        view.addSubview(noCellsView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadItems()
        collectionView.reloadData()
    }
    

//MARK: - Collection View DataSource Methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activeFilmRolls.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as ActiveFilmRollCell
        cell.delegate = self
        let activeFilmRoll = activeFilmRolls[indexPath.row]
        cell.activeFilmRollViewModel = ActiveFilmRollViewModel(activeFilmRoll)
        return cell
    }
    
    
//MARK: - Collection View FlowLayout Delegate Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 40, height: 180)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let framesTableViewController = FramesTableViewController()
        framesTableViewController.navigationItem.title = activeFilmRolls[indexPath.row].title
        framesTableViewController.maxFrames = activeFilmRolls[indexPath.row].frameCount
        if let colorName = activeFilmRolls[indexPath.row].colorName {
            if let filmColor = Color.gradientDictionary[colorName] {
                ActiveRollTheme.current = filmColor
            }
            
        }
        navigationController?.pushViewController(framesTableViewController, animated: true)
    }
    
    
//MARK: - Navigation Bar Item Methods
    @objc func addTapped() {
        let addNewRollTableViewController = NewRollTableViewController()
        let addNewRollNavController = UINavigationController(rootViewController: addNewRollTableViewController)
        self.present(addNewRollNavController, animated: true, completion: nil)
        
    }
    
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
    
    
//MARK: - Setup Methods
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
        collectionView.register(ActiveFilmRollCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0,right: 0)
    }
    
    
//MARK: - Model Manipulation Methods
    func saveItems() {
        do{
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func loadItems(with request: NSFetchRequest<ActiveFilmRoll> = ActiveFilmRoll.fetchRequest()) {
        do {
            activeFilmRolls = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}


//MARK: - ActiveFilmRollCellDelegate Methods
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
