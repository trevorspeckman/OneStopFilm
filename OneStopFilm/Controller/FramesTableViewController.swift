//
//  FramesTableViewController.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/1/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

class FramesTableViewController: UITableViewController {

    let framesTableModel = FramesTableModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupTableView()
        
    }
    
    override func willMove(toParent parent: UIViewController?) {
        navigationController?.navigationBar.barTintColor = .white
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return framesTableModel.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = framesTableModel.items[indexPath.row]
        item.register(in: tableView)
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId)!
        item.configure(cell: cell)
        
        return cell
        
    }
    
    
    
    
    //MARK: Delegate Methods
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BaseTableViewCell.cellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    
    
    //MARK: Setup Methods
    fileprivate func setupNavBar() {
        navigationItem.title = "TRIP TO YOSEMITE"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Theme.Font.titleFont!]
        self.navigationController?.navigationBar.barTintColor = Theme.Color.yellow
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    fileprivate func setupTableView() {
        tableView.tableFooterView = UIView()
    }
    
   

}




