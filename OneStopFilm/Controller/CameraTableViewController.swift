//
//  CameraTableViewController.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 6/27/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit
import CoreData

class CameraTableViewController: UITableViewController {
    
    var cameraArray = [Camera]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedParentViewCellIndex = 0
    var delegate: ChildViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        loadItems()
        //        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }
    
    
    let addCameraPopup = AddCameraPopup()
    
    @objc func addTapped() {
        
        if let window = UIApplication.shared.keyWindow {
            addCameraPopup.table.reloadData()
            addCameraPopup.saveButton.setTitleColor(.officialApplePlaceholderGray, for: .normal)
            addCameraPopup.isEmptyArray = [Bool?](repeating: nil, count:addCameraPopup.addCameraPopUpModel.count)
            addCameraPopup.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            addCameraPopup.cancelButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cancelTapped)))
            addCameraPopup.saveButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(saveTapped)))
            
            window.addSubview(addCameraPopup)
            addCameraPopup.frame = window.frame
            addCameraPopup.alpha = 0
            
            UIView.animate(withDuration: 0.5) {
                self.addCameraPopup.alpha = 1
            }
        }
        
    }
    
    @objc func cancelTapped() {
        UIView.animate(withDuration: 0.5) {
            self.addCameraPopup.alpha = 0
        }
        addCameraPopup.endEditing(true)
        
    }
    
    @objc func saveTapped() {
        UIView.animate(withDuration: 0.5) {
            self.addCameraPopup.alpha = 0
        }
        addCameraPopup.endEditing(true)
        
        let newFilm = Camera(context: context)
        newFilm.brand = addCameraPopup.typedText[0]
        newFilm.name = addCameraPopup.typedText[1]
        
        saveItems()
        loadItems()
        tableView.reloadData()
        
        
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cameraArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        if let brand = cameraArray[indexPath.row].brand {
            if let name = cameraArray[indexPath.row].name {
                cell.textLabel?.text = "\(brand) \(name)"
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            context.delete(cameraArray[indexPath.row])
            saveItems()
            
            cameraArray.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        self.delegate?.childViewControllerResponse(response: cell?.textLabel?.text ?? "", selectedParentViewCellIndex: selectedParentViewCellIndex)
        navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return "Cameras"
    }
    
    
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    //MARK: Setup Methods
    fileprivate func setupNavBar() {
        navigationItem.title = "CAMERAS"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Theme.Font.titleFont!]
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        
        // Setup the Search Controller
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "SEARCH CAMERAS"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    //MARK: Model Manipulation Methods
    func saveItems() {
        
        do{
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
    }
    
    func loadItems(with request: NSFetchRequest<Camera> = Camera.fetchRequest()) {
        
        request.sortDescriptors = [NSSortDescriptor(key: "brand", ascending: true), NSSortDescriptor(key: "name", ascending: true)]
        do {
            cameraArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    
    
}

extension CameraTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let request : NSFetchRequest<Camera> = Camera.fetchRequest()
        
        guard let searchText = searchController.searchBar.text else {return}
        let search = searchText.trimmingCharacters(in: .whitespaces)
        let words = search.components(separatedBy: NSCharacterSet.whitespaces)
        if !search.isEmpty {
            let predicates = words.map { NSPredicate(format: "brand CONTAINS[cd] %@ OR name CONTAINS[cd] %@", $0,$0) }
            request.predicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: predicates)
        }
        
        
        
        loadItems(with: request)
        tableView.reloadData()
    }
    
}
