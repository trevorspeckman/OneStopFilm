//
//  AddFilmPopUp.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/1/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

class AddFilmPopUp: BasePopUp, UITableViewDelegate, UITableViewDataSource {

//MARK: Subview Initialization
    
    let addFilmPopUpModel = AddFilmPopUpModel()

    fileprivate let table: SelfSizedTableView = {
        let tableView = SelfSizedTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //tableView.backgroundColor = .red
        tableView.tableFooterView = UIView()
        tableView.alwaysBounceVertical = false;
        return tableView
    }()
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.green
        label.text = "ADD FILM"
        label.font = Theme.Font.titleLabelFont!
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    fileprivate lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel,table,buttonStackView])
        stack.axis = NSLayoutConstraint.Axis.vertical
        stack.spacing = 5
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func setupViews() {
        super.setupViews()
        table.tableFooterView?.isHidden = true
        table.delegate = self
        table.dataSource = self
        
        addSubview(container)
        container.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10).isActive = true
        
        
        
        container.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
//        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45).isActive = true
        
        
        
    }
    
// MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addFilmPopUpModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = addFilmPopUpModel.items[indexPath.row]
        item.register(in: tableView)
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId)!
        item.configure(cell: cell)
        
        return cell
        
    }
    
    
    
    
//MARK: Delegate Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BaseTableViewCell.cellHeight
    }
    
   
    
   
    
}
