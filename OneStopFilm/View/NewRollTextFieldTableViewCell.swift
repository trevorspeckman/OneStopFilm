//
//  TextFieldTableViewCell.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 6/25/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit


class NewRollTextFieldTableViewCell: BaseTableViewCell, ConfigurableCell, UITextFieldDelegate {


    
//MARK: Subview Initialization
    let titleLabel: UILabel = {
        let label = UILabel()
//        label.backgroundColor = UIColor.red
        label.alpha = 0
        label.font = Theme.Font.newRollTitleLabelFont!
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cellTextField: UITextField = {
        let textField = UITextField()
//        textField.backgroundColor = UIColor.green
        textField.adjustsFontSizeToFitWidth = true

        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var textLengthLimit = 0
    
    override func setupViews() {
        
        cellTextField.delegate = self
        
        cellTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        addSubview(titleLabel)
        addSubview(cellTextField)
        
        titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 1).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25).isActive = true
        
        
        cellTextField.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.topAnchor, multiplier: 1).isActive = true
        cellTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        cellTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        //cellTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
        cellTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        selectionStyle = .none


    }
    
//MARK: ConfigurableCell Protocol Methods
    func configure(data newRoll: NewRollTextField) {
        titleLabel.text = newRoll.text
        cellTextField.placeholder = newRoll.text
        if newRoll.keyboard == 0 {
            cellTextField.keyboardType = .default
        } else if newRoll.keyboard == 1 {
            cellTextField.keyboardType = .numberPad
        }
        textLengthLimit = newRoll.textLengthLimit
        
    }
    
//MARK: TextField Delegate Methods
    @objc func textFieldDidChange(_ textField: UITextField) {
        if cellTextField.text?.isEmpty == false {

            titleLabel.fadeIn()
            titleLabel.textColor = UIColor.orange
        }
        else {
            titleLabel.fadeOut()
        }
        
        cellTextField.text =  cellTextField.text?.uppercased()
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if cellTextField.text?.isEmpty == false {
            titleLabel.textColor = UIColor.orange
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //titleLabel.fadeOut()
        titleLabel.textColor = UIColor.gray
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = cellTextField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= textLengthLimit
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    

}
