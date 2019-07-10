//
//  AddNewRollTableViewController.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 6/25/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit
import CoreData



class NewRollTableViewController: UITableViewController, ChildViewControllerDelegate, NewRollTextFieldTableViewCellDelegate {
    
    
    

    
    let newRollModel = NewRollModel()
    var filmResponseText = "FILM"
    var cameraResponseText = "CAMERA"
    var gradient = Gradient(name: "", color1: .clear, color2: .clear)
    lazy var tableData = [String?](repeating: nil, count:newRollModel.items.count)
    lazy var isEmptyArray = [Bool?](repeating: nil, count:newRollModel.items.count)
    
    
    var delegate: NewRollTableViewController?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        
        if indexPath.row == 0 {
            let cell = cell as! NewRollTextFieldTableViewCell
            cell.delegate = self
        }
        else if indexPath.row == 1 {
            let cell = cell as! NewRollLabelTableViewCell
            cell.selectionLabel.text = filmResponseText
            if filmResponseText != "FILM" {
                cell.selectionLabel.textColor = .black
                cell.titleLabel.alpha = 1
                tableData[indexPath.row] = filmResponseText
                isEmptyArray[indexPath.row] = false
                
                if isEmptyArray.allSatisfy({$0 == false}) {
                    navigationItem.rightBarButtonItem?.isEnabled = true
                    navigationItem.rightBarButtonItem?.tintColor = .orange
                } else {
                    
                    navigationItem.rightBarButtonItem?.isEnabled = false
                    navigationItem.rightBarButtonItem?.tintColor = .officialApplePlaceholderGray
                }
            }
            return cell
        }
        else if indexPath.row == 2 {
            let cell = cell as! NewRollTextFieldTableViewCell
            cell.delegate = self
        }
            
        else if indexPath.row == 3 {
            let cell = cell as! NewRollTextFieldTableViewCell
            cell.delegate = self
        }
            
        else if indexPath.row == 4 {
            let cell = cell as! NewRollLabelTableViewCell
            cell.selectionLabel.text = cameraResponseText
            if cameraResponseText != "CAMERA" {
                cell.selectionLabel.textColor = .black
                cell.titleLabel.alpha = 1
                tableData[indexPath.row] = cameraResponseText
                isEmptyArray[indexPath.row] = false
                
                if isEmptyArray.allSatisfy({$0 == false}) {
                    navigationItem.rightBarButtonItem?.isEnabled = true
                    navigationItem.rightBarButtonItem?.tintColor = .orange
                } else {
                    
                    navigationItem.rightBarButtonItem?.isEnabled = false
                    navigationItem.rightBarButtonItem?.tintColor = .officialApplePlaceholderGray
                }
            }
        }
            
        else if indexPath.row == 5 {
            let cell = cell as! NewRollLabelTableViewCell
            
            if gradient.color1 != .clear {
                cell.selectionLabel.setGradientBackground(colorOne: gradient.color1, colorTwo: gradient.color2, locations: [0.0,1.0], startPoint: CGPoint(x: 0.0, y: 0.0), endPoint: CGPoint(x: 1.0, y: 1.0))
                cell.selectionLabel.textColor = .clear
                cell.titleLabel.alpha = 1
                tableData[indexPath.row] = gradient.name
                isEmptyArray[indexPath.row] = false
                
                if isEmptyArray.allSatisfy({$0 == false}) {
                    navigationItem.rightBarButtonItem?.isEnabled = true
                    navigationItem.rightBarButtonItem?.tintColor = .orange
                } else {
                    
                    navigationItem.rightBarButtonItem?.isEnabled = false
                    navigationItem.rightBarButtonItem?.tintColor = .officialApplePlaceholderGray
                }
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
        
        let newActiveFilmRoll = ActiveFilmRoll(context: context)
        
        
        
        newActiveFilmRoll.title = tableData[0]
        newActiveFilmRoll.film = tableData[1]
        newActiveFilmRoll.filmSpeed = Int16(tableData[2]!)!
        newActiveFilmRoll.frameCount = Int16(tableData[3]!)!
        newActiveFilmRoll.camera = tableData[4]
        newActiveFilmRoll.colorName = tableData[5]
        newActiveFilmRoll.date = Date()
        
        saveItems()
    }
    
    //MARK: Setup Methods
    fileprivate func setupNavBar() {
        navigationItem.title = "NEW ROLL"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Theme.Font.titleFont!]
        self.navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.rightBarButtonItem?.isEnabled = false;
        navigationItem.rightBarButtonItem?.tintColor = .officialApplePlaceholderGray
    }
    
    fileprivate func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.alwaysBounceVertical = false
    }
    
    //MARK: childViewController Delegate Methods
    func childViewControllerResponse(response: Any, selectedParentViewCellIndex: Int) {
        if selectedParentViewCellIndex == 1 {
            filmResponseText = response as! String
        } else if selectedParentViewCellIndex == 4 {
            cameraResponseText = response as! String
        } else {
            gradient = response as! Gradient
        }
        
        tableView.reloadData()
    }
    
    //MARK: NewRollTextFieldTableViewCellDelegate Methods
    func textFieldDidEndEditing(text: String, cell: NewRollTextFieldTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            tableData[indexPath.row] = text
        }
    }
    
    func textFieldDidChange(text: String?, cell: NewRollTextFieldTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            if text?.isEmpty == false {
                isEmptyArray[indexPath.row] = false
            } else {
                isEmptyArray[indexPath.row] = true
            }
            
            if isEmptyArray.allSatisfy({$0 == false}) {
                navigationItem.rightBarButtonItem?.isEnabled = true
                navigationItem.rightBarButtonItem?.tintColor = .orange
            } else {
                
                navigationItem.rightBarButtonItem?.isEnabled = false
                navigationItem.rightBarButtonItem?.tintColor = .officialApplePlaceholderGray
            }
        }
    }
    
    
    
    //MARK: Model Manipulation Methods
    func saveItems() {
        
        do{
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
    }
    
}
