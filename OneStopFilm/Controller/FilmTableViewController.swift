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
    func childViewControllerResponse(response: String)
}

class FilmTableViewController: UITableViewController {

    var filmArray = [Film]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var delegate: ChildViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        loadItems()
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }
    
    
    let addFilmPopup = AddFilmPopUp()
    
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
        self.delegate?.childViewControllerResponse(response: cell?.textLabel?.text ?? "")
        navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Film"
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return BaseTableViewCell.cellHeight
//    }

    //MARK: Setup Methods
    fileprivate func setupNavBar() {
        navigationItem.title = "FILM"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Theme.Font.titleFont!]
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
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
        let request: NSFetchRequest<Film> = Film.fetchRequest()
        do {
            filmArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
}
