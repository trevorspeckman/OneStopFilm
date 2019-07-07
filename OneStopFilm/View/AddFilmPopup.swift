//
//  AddFilmPopUp.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/1/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

class AddFilmPopup: BasePopup, UITableViewDelegate, UITableViewDataSource, NewRollTextFieldTableViewCellDelegate {
    
    
    
    

//MARK: Subview Initialization
    
    var addFilmPopUpModel = [NewRollTextField]()
    lazy var typedText = [String?](repeating: nil, count:addFilmPopUpModel.count)
    lazy var isEmptyArray = [Bool?](repeating: nil, count:addFilmPopUpModel.count)
    let table: SelfSizedTableView = {
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
        
        table.dataSource = self
        table.delegate = self
        table.register(NewRollTextFieldTableViewCell.self, forCellReuseIdentifier: "cellId")
        
        setupModel()
        
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
        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
       
        
        
        
    }
    
// MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addFilmPopUpModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! NewRollTextFieldTableViewCell
        cell.delegate = self
        cell.newRoll = addFilmPopUpModel[indexPath.row]
        return cell
        
    }
    
//MARK: Setup addFilmPopUpModel
    func setupModel() {
        let cell1 = NewRollTextField(text: "BRAND", textLengthLimit: 20, keyboard: 0)
        let cell2 = NewRollTextField(text: "FILM NAME", textLengthLimit: 20, keyboard: 0)
        addFilmPopUpModel = [cell1,cell2]
    }
    
    
//MARK: Delegate Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BaseTableViewCell.cellHeight
    }
    
    //MARK: NewRoll Delegate
    func textFieldDidEndEditing(text: String, cell: NewRollTextFieldTableViewCell) {
        if let indexPath = table.indexPath(for: cell) {
            typedText[indexPath.row] = text
        }
        
    }
    
    func textFieldDidChange(text: String?, cell: NewRollTextFieldTableViewCell) {
        if let indexPath = table.indexPath(for: cell) {
            if text?.isEmpty == false {
                isEmptyArray[indexPath.row] = false
            } else {
                isEmptyArray[indexPath.row] = true
            }
            
            if isEmptyArray.allSatisfy({$0 == false}) {
                saveButton.isEnabled = true
                saveButton.setTitleColor(.orange, for: .normal)
            } else {
                saveButton.isEnabled = false
                saveButton.setTitleColor(.officialApplePlaceholderGray, for: .normal)
            }
        }
        
    }
    
   
    
}
