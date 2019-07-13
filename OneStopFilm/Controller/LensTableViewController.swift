//
//  LensTableViewController.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/12/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit
import CoreData

class LensTableViewController: UITableViewController {
    
    var lensArray = [Lens]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedParentViewCellIndex = 0
    var delegate: ChildViewControllerDelegate?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        loadItems()
        //        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }
    
    override func willMove(toParent parent: UIViewController?) {
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: Theme.Font.titleFont!]
        if let navigationBar = self.navigationController?.navigationBar {
            let gradientColors = ActiveRollTheme.current
            navigationBar.setGradientBackgroundImage(colorOne: gradientColors.colorOne, colorTwo: gradientColors.colorTwo)
        }
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    
    let addLensPopup = AddLensPopup()
    
    @objc func addTapped() {
        
        if let window = UIApplication.shared.keyWindow {
            addLensPopup.table.reloadData()
            addLensPopup.saveButton.setTitleColor(Theme.current.placeholderColor, for: .normal)
            addLensPopup.isEmptyArray = [Bool?](repeating: nil, count:addLensPopup.addLensPopUpModel.count)
            addLensPopup.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            addLensPopup.cancelButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cancelTapped)))
            addLensPopup.saveButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(saveTapped)))
            
            window.addSubview(addLensPopup)
            addLensPopup.frame = window.frame
            addLensPopup.alpha = 0
            
            UIView.animate(withDuration: 0.5) {
                self.addLensPopup.alpha = 1
            }
        }
        
    }
    
    @objc func cancelTapped() {
        UIView.animate(withDuration: 0.5) {
            self.addLensPopup.alpha = 0
        }
        addLensPopup.endEditing(true)
        
    }
    
    @objc func saveTapped() {
        UIView.animate(withDuration: 0.5) {
            self.addLensPopup.alpha = 0
        }
        addLensPopup.endEditing(true)
        
        let newLens = Lens(context: context)
        newLens.brand = addLensPopup.typedText[0]
        newLens.focalLength = Int16(addLensPopup.typedText[1]!)!
        newLens.minAperature = Float(addLensPopup.typedText[2]!)!
        newLens.maxAperature = Float(addLensPopup.typedText[3]!)!
        
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
        return lensArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") else {
                return UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cellId")
            }
            return cell
        }()
        
        if let brand = lensArray[indexPath.row].brand {
            let focalLength = lensArray[indexPath.row].focalLength
            let minAperature = lensArray[indexPath.row].minAperature
            let maxAperature = lensArray[indexPath.row].maxAperature
            cell.textLabel?.text = "\(brand) \(focalLength)mm"
            cell.detailTextLabel?.text = "(f/\(minAperature) - f/\(maxAperature))"
            cell.detailTextLabel?.textColor = Theme.current.subtitleTextColor
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            context.delete(lensArray[indexPath.row])
            saveItems()
            
            lensArray.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        self.delegate?.childViewControllerResponse(response: cell?.textLabel?.text ?? "", selectedParentViewCellIndex: selectedParentViewCellIndex)
        navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Lenses"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BaseTableViewCell.cellHeight
    }
    
    
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    //MARK: Setup Methods
    fileprivate func setupNavBar() {
        navigationItem.title = "LENSES"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Theme.Font.titleFont!]
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.setGradientBackgroundImage(colorOne: Theme.current.cellColor, colorTwo: Theme.current.cellColor)
        }
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.current.textColor, NSAttributedString.Key.font: Theme.Font.titleFont!]
        self.navigationController?.navigationBar.tintColor = Theme.current.textColor
        self.navigationController?.navigationBar.barStyle = Theme.current.barStyle
        
        // Setup the Search Controller
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "SEARCH LENSES"
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
    
    func loadItems(with request: NSFetchRequest<Lens> = Lens.fetchRequest()) {
        
        request.sortDescriptors = [NSSortDescriptor(key: "brand", ascending: true), NSSortDescriptor(key: "focalLength", ascending: true)]
        do {
            lensArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    
    
}





extension LensTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let request : NSFetchRequest<Lens> = Lens.fetchRequest()
        
        guard let searchText = searchController.searchBar.text else {return}
        let search = searchText.trimmingCharacters(in: .whitespaces)
        let words = search.components(separatedBy: NSCharacterSet.whitespaces)
        if !search.isEmpty {
            let predicates = words.map { NSPredicate(format: "brand CONTAINS[cd] %@ OR focalLength CONTAINS[cd] %@", $0,$0) }
            request.predicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: predicates)
        }
        
        
        
        loadItems(with: request)
        tableView.reloadData()
    }
    
}
