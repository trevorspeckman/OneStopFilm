//
//  AddNewRollTableViewController.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 6/25/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit
import CoreData



class NewRollTableViewController: UITableViewController, ChildViewControllerDelegate {
    
    

    let newRollModel = NewRollModel()
    var filmResponseText = "FILM"
    var cameraResponseText = "CAMERA"
    var colorBackground = UIColor.white
    var lightColorBackground = UIColor.white
    var delegate: NewRollTableViewController?
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        setupTableView()
        

    }

// MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newRollModel.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = newRollModel.items[indexPath.row]
        item.register(in: tableView)
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId)!
        item.configure(cell: cell)
        
        if indexPath.row == 1 {
            let cell = cell as! NewRollLabelTableViewCell
            cell.selectionLabel.text = filmResponseText
            if filmResponseText != "FILM" {
                cell.selectionLabel.textColor = .black
                cell.titleLabel.alpha = 1
            }
            return cell
        }
            
        else if indexPath.row == 4 {
            let cell = cell as! NewRollLabelTableViewCell
            cell.selectionLabel.text = cameraResponseText
            if cameraResponseText != "CAMERA" {
                cell.selectionLabel.textColor = .black
                cell.titleLabel.alpha = 1
            }
        }
            
        else if indexPath.row == 5 {
            let cell = cell as! NewRollLabelTableViewCell
            
            if colorBackground != .white {
                cell.selectionLabel.setGradientBackground(colorOne: colorBackground, colorTwo: lightColorBackground, locations: [0.0,1.0], startPoint: CGPoint(x: 0.0, y: 0.0), endPoint: CGPoint(x: 1.0, y: 1.0))
                cell.selectionLabel.textColor = .clear
                cell.titleLabel.alpha = 1
            }
            
        }
        return cell
    }
    


   
//MARK: Delegate Methods
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BaseTableViewCell.cellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.endEditing(true)
        if indexPath.row == 1 {
            tableView.deselectRow(at: indexPath, animated: true)
            let filmTableViewController = FilmTableViewController()
            filmTableViewController.selectedParentViewCellIndex = indexPath.row
            filmTableViewController.delegate = self
            navigationController?.pushViewController(filmTableViewController, animated: true)
        }
        else if indexPath.row == 4 {
            tableView.deselectRow(at: indexPath, animated: true)
            let cameraTableViewController = CameraTableViewController()
            cameraTableViewController.selectedParentViewCellIndex = indexPath.row
            cameraTableViewController.delegate = self
            navigationController?.pushViewController(cameraTableViewController, animated: true)
            
        }
        else if indexPath.row == 5 {
            tableView.deselectRow(at: indexPath, animated: true)
            
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            
            
            let colorCollectionViewController =  ColorCollectionViewController(collectionViewLayout: layout)
            colorCollectionViewController.selectedParentViewCellIndex = indexPath.row
            colorCollectionViewController.delegate = self
            navigationController?.pushViewController(colorCollectionViewController, animated: true)
        }
    }
    

//MARK: Tapped Functions
    @objc func cancelTapped() {
        self.dismiss(animated: true, completion: nil)
        self.view.endEditing(true)
    }
    
    @objc func saveTapped() {
        self.dismiss(animated: true, completion: nil)
        self.view.endEditing(true)
    }
    
//MARK: Setup Methods
    fileprivate func setupNavBar() {
        navigationItem.title = "NEW ROLL"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Theme.Font.titleFont!]
        self.navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
    }
    
    fileprivate func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.alwaysBounceVertical = false;
    }
    
    //MARK: childViewController Delegate Methods
    func childViewControllerResponse(response: Any, selectedParentViewCellIndex: Int) {
        if selectedParentViewCellIndex == 1 {
            filmResponseText = response as! String
        } else if selectedParentViewCellIndex == 4 {
            cameraResponseText = response as! String
        } else {
            let responseArray = response as! [UIColor]
            colorBackground = responseArray[0]
            lightColorBackground = responseArray[1]
        }
        
        tableView.reloadData()
    }
    

}
