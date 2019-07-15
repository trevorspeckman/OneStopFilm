//
//  BasePopup.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/14/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

protocol BasePopupDelegate{
    func saveData()
}



class BasePopupTest: UIView {
    
    
    var delegate: BasePopupDelegate?
    
    
    //MARK: Subview Initialization
    
    var modelArray = [NewRollTextField]()
    lazy var typedText = [String?](repeating: nil, count:modelArray.count)
    lazy var isEmptyArray = [Bool?](repeating: nil, count:modelArray.count)
    
        
    init(model: [NewRollTextField]){
        super.init(frame: CGRect.zero)
        self.modelArray = model
        setupViews()
        
    }
    
     let table: SelfSizedTableView = {
        let tableView = SelfSizedTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //tableView.backgroundColor = .red
        tableView.tableFooterView = UIView()
        tableView.alwaysBounceVertical = false;
        return tableView
    }()
    
     let titleLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.green
        label.font = Theme.Font.titleLabelFont!
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        //button.backgroundColor = .blue
        button.setTitle("Add", for: .normal)
        button.isEnabled = false
        button.setTitleColor(Theme.current.placeholderColor, for: .normal)
        button.layer.masksToBounds = true
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        // button.backgroundColor = .yellow
        button.setTitleColor(Theme.current.textColor, for: .normal)
        button.setTitle("Cancel", for: .normal)
        
        
        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cancelButton,saveButton])
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.current.popupColor
        view.layer.cornerRadius = 15
        return view
    }()
    
    fileprivate lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel,table,buttonStackView])
        stack.axis = NSLayoutConstraint.Axis.vertical
        stack.spacing = 5
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    @objc func cancelTapped() {

            print("cancel")
            UIView.animate(withDuration: 0.5) {
                self.alpha = 0
            }

            self.endEditing(true)
    
    }
    
    @objc func saveTapped() {

        UIView.animate(withDuration: 0.5) {
            self.alpha = 0
        }
        self.endEditing(true)
        delegate?.saveData()
    }
    
    func setupViews() {
        
        table.dataSource = self
        table.delegate = self
        table.register(NewRollTextFieldTableViewCell.self)
        table.tableFooterView?.isHidden = true
        table.delegate = self
        table.dataSource = self
        
        
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        
        
        
        
        
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
    func setupModel() {}
    
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension BasePopupTest: UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: NewRollTextFieldTableViewCell.reuseIdentifier, for: indexPath) as! NewRollTextFieldTableViewCell
        cell.delegate = self
        cell.newRoll = modelArray[indexPath.row]
        return cell
        
    }
    
    
    //MARK: Delegate Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BaseTableViewCell.cellHeight
    }
    

}




extension BasePopupTest: NewRollTextFieldTableViewCellDelegate {
    
    
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
                saveButton.setTitleColor(Theme.current.tintColor, for: .normal)
            } else {
                saveButton.isEnabled = false
                saveButton.setTitleColor(.officialApplePlaceholderGray, for: .normal)
            }
        }
    }

    
}
