//
//  FilmStockTableViewController.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 6/27/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit
import CoreData

protocol ChildViewControllerDelegate {
    func childViewControllerResponse(response: Any, selectedParentViewCellIndex: Int)
}

class FilmTableViewController: UITableViewController {
    


    var filmArray = [Film]()
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
    
    
    let addFilmPopup = AddFilmPopup()
    
    @objc func addTapped() {
        
        if let window = UIApplication.shared.keyWindow {
            addFilmPopup.table.reloadData()
            addFilmPopup.saveButton.setTitleColor(.officialApplePlaceholderGray, for: .normal)
            addFilmPopup.isEmptyArray = [Bool?](repeating: nil, count:addFilmPopup.addFilmPopUpModel.count)
            addFilmPopup.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            addFilmPopup.cancelButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cancelTapped)))
            addFilmPopup.saveButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(saveTapped)))
            
            window.addSubview(addFilmPopup)
            addFilmPopup.frame = window.frame
            addFilmPopup.alpha = 0
            
            UIView.animate(withDuration: 0.5) {
                self.addFilmPopup.alpha = 1
            }
        }
        
    }
    
    @objc func cancelTapped() {
        UIView.animate(withDuration: 0.5) {
            self.addFilmPopup.alpha = 0
        }
        addFilmPopup.endEditing(true)
    }
    @objc func saveTapped() {
        UIView.animate(withDuration: 0.5) {
            self.addFilmPopup.alpha = 0
        }
        addFilmPopup.endEditing(true)

        let newFilm = Film(context: context)
        newFilm.brand = addFilmPopup.typedText[0]
        newFilm.name = addFilmPopup.typedText[1]
        
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
        return filmArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        if let brand = filmArray[indexPath.row].brand {
            if let name = filmArray[indexPath.row].name {
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
            context.delete(filmArray[indexPath.row])
            saveItems()
            
            filmArray.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        self.delegate?.childViewControllerResponse(response: cell?.textLabel?.text ?? "", selectedParentViewCellIndex: selectedParentViewCellIndex)
        
        navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
  
        
        return "Film"
    }
    
let searchController = UISearchController(searchResultsController: nil)

    //MARK: Setup Methods
    fileprivate func setupNavBar() {
        navigationItem.title = "FILM"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Theme.Font.titleFont!]
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        

        // Setup the Search Controller
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "SEARCH FILMS"
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
    
    func loadItems(with request: NSFetchRequest<Film> = Film.fetchRequest()) {

        request.sortDescriptors = [NSSortDescriptor(key: "brand", ascending: true), NSSortDescriptor(key: "name", ascending: true)]
        do {
            filmArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    
    
}

extension FilmTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
  

    
    func updateSearchResults(for searchController: UISearchController) {
        let request : NSFetchRequest<Film> = Film.fetchRequest()
        
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

