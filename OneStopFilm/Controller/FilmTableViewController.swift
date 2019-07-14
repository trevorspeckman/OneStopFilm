//
//  FilmStockTableViewController.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 6/27/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit
import CoreData



class FilmTableViewController: UITableViewController {
    
//MARK - Define Global Variables/Constants
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //var filmArray = [Film]()
    
    var selectedParentViewCellIndex: Int?
    
    var delegate: ChildViewControllerDelegate?
    
    let searchController = UISearchController(searchResultsController: nil)
    let addFilmPopup = AddFilmPopup()

    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Film> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Film> = Film.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "brand", ascending: true), NSSortDescriptor(key: "name", ascending: true)]
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    
    fileprivate func updateView() {
        var hasFilm = false
        
        if let films = fetchedResultsController.fetchedObjects {
            hasFilm = films.count > 0
        }
        
        //tableView.isHidden = !hasFilm
    }
    
//MARK - View Controller Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
        loadItems()
    }
    
    
    
//MARK: - Navigation Bar Item and popup Methods
    @objc func addTapped() {
        
        if let window = UIApplication.shared.keyWindow {
            addFilmPopup.table.reloadData()
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
    }


// MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let films = fetchedResultsController.fetchedObjects else {return 0}
        
        return films.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        
        let film = fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = "\(film.brand ?? "") \(film.name ?? "")"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Film"
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
           let film = fetchedResultsController.object(at: indexPath)
            film.managedObjectContext?.delete(film)
        }
    }
    
    
//MARK - TableView Delegate Methods

    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = Theme.current.textColor
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        self.delegate?.childViewControllerResponse(response: cell?.textLabel?.text ?? "", selectedParentViewCellIndex: selectedParentViewCellIndex!)
        
        navigationController?.popViewController(animated: true)
    }
    

//MARK: - Setup Methods
    fileprivate func setupNavBar() {
        navigationItem.title = "FILM"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Theme.Font.titleFont!]
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        self.navigationController?.navigationBar.tintColor = Theme.current.textColor
        self.navigationController?.navigationBar.barTintColor = Theme.current.cellColor
        self.navigationController?.navigationBar.barStyle = Theme.current.barStyle
        
        // Setup the Search Controller
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "SEARCH FILMS"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    fileprivate func setupTableView() {
        tableView.register(UITableViewCell.self)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = Theme.current.cellColor
    }
    
    
//MARK: Model Manipulation Methods
    func saveItems() {
        do{
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func loadItems() {
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("Unable to Perform Fetch Request")
            print("\(fetchError), \(fetchError.localizedDescription)")
        }
        self.updateView()
    }
}


//MARK: - Seach Bar Delegate Methods
extension FilmTableViewController: UISearchResultsUpdating, UISearchBarDelegate {

    func updateSearchResults(for searchController: UISearchController) {

        guard let searchText = searchController.searchBar.text else {return}
        let search = searchText.trimmingCharacters(in: .whitespaces)
        let words = search.components(separatedBy: NSCharacterSet.whitespaces)
        if !search.isEmpty {
            let predicate = words.map { NSPredicate(format: "brand CONTAINS[cd] %@ OR name CONTAINS[cd] %@", $0,$0) }
            self.fetchedResultsController.fetchRequest.predicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: predicate)
        } else {

            fetchedResultsController.fetchRequest.predicate = nil

        }
        
        

        loadItems()
        tableView.reloadData()
    }

}



extension FilmTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            saveItems()
            break;
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            saveItems()
            break;
        default:
            print("...")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
        updateView()
    }
    
    
}
