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
            let colorCollectionViewController =  ColorCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
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
    func childViewControllerResponse(response: String, selectedParentViewCellIndex: Int) {
        if selectedParentViewCellIndex == 1 {
            filmResponseText = response
        } else {
            cameraResponseText = response
        }
        
        tableView.reloadData()
    }
    

}
