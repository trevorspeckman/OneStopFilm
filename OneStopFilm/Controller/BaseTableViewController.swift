//
//  BaseTableViewController.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/14/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit
import CoreData



class BaseTableViewController: UITableViewController {
    
    //MARK - Define Global Variables/Constants
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedParentViewCellIndex: Int?
    
    var delegate: ChildViewControllerDelegate?
    
    var listModel: ListModelProtocol

    let searchController = UISearchController(searchResultsController: nil)
   
    
         lazy var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> = {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.listModel.entityName)
            fetchRequest.sortDescriptors = self.listModel.sortDescriptors
            let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController.delegate = self
            return fetchedResultsController
        }()
    
    
    fileprivate func updateView() {
        
    }
    
    
//MARK: - init Methods
    required init<T: ListModelProtocol>(listModelProtocol: T){
        self.listModel = listModelProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK - View Controller Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
        loadItems()
        
    }
    
    override func willMove(toParent parent: UIViewController?) {
        if listModel.needsToChangeNavBarBackground {
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: Theme.Font.titleFont!]
            if let navigationBar = self.navigationController?.navigationBar {
                let gradientColors = ActiveRollTheme.current
                navigationBar.setGradientBackgroundImage(colorOne: gradientColors.colorOne, colorTwo: gradientColors.colorTwo)
            }
            self.navigationController?.navigationBar.tintColor = .white
            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationController?.navigationBar.barStyle = .black
        }
       
    }
    
    
    
//MARK: - Navigation Bar Item and popup Methods
    @objc func addTapped() {
        
        if let window = UIApplication.shared.keyWindow {
            let popup = listModel.addItemPopup
            popup.delegate = self
            popup.table.reloadData()
            
            popup.isEmptyArray = [Bool?](repeating: nil, count:popup.modelArray.count)
            
            popup.backgroundColor = UIColor(white: 0, alpha: 0.5)
            popup.titleLabel.text = "ADD \(listModel.entityName.uppercased())"

            window.addSubview(popup)
            popup.frame = window.frame
            popup.alpha = 0
            
            UIView.animate(withDuration: 0.5) {
                popup.alpha = 1
            }
            
        }
        
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
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") else {
                return UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cellId")
            }
            return cell
        }()
        listModel.configureCell(cell, at: indexPath, with: fetchedResultsController)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return listModel.entityName
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let model = fetchedResultsController.object(at: indexPath)
            fetchedResultsController.managedObjectContext.delete(model as! NSManagedObject)
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
        navigationItem.title = listModel.entityName.uppercased()
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Theme.Font.titleFont!]
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        if listModel.needsToChangeNavBarBackground{
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Theme.Font.titleFont!]
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
            
            if let navigationBar = self.navigationController?.navigationBar {
                navigationBar.setGradientBackgroundImage(colorOne: Theme.current.cellColor, colorTwo: Theme.current.cellColor)
            }
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.current.textColor, NSAttributedString.Key.font: Theme.Font.titleFont!]
            self.navigationController?.navigationBar.tintColor = Theme.current.textColor
            self.navigationController?.navigationBar.barStyle = Theme.current.barStyle
        } else{
            self.navigationController?.navigationBar.tintColor = Theme.current.textColor
            self.navigationController?.navigationBar.barTintColor = Theme.current.cellColor
            self.navigationController?.navigationBar.barStyle = Theme.current.barStyle
        }
        
        
        // Setup the Search Controller
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = listModel.searchBarPlaceholderText
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
extension BaseTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text else {return}
        let search = searchText.trimmingCharacters(in: .whitespaces)
        let words = search.components(separatedBy: NSCharacterSet.whitespaces)
        if !search.isEmpty {
        let attributeOne = listModel.attributeNamesToFilter[0]
        let attributeTwo = listModel.attributeNamesToFilter[1]
        let predicate = words.map { NSPredicate(format: "\(attributeOne) CONTAINS[cd] %@ OR \(attributeTwo) CONTAINS[cd] %@", $0,$0) }
        self.fetchedResultsController.fetchRequest.predicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: predicate)
            
        } else {
            fetchedResultsController.fetchRequest.predicate = nil
        }
        
        
        
        loadItems()
        tableView.reloadData()
    }
    
}



extension BaseTableViewController: NSFetchedResultsControllerDelegate {
    
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

extension BaseTableViewController: BasePopupDelegate {
    func saveData() {
           listModel.saveData(context: context)
        }

}
