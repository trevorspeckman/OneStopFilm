//
//  TextFieldTableViewCell.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 6/25/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

//protocol TextFieldTableViewCellDelegate {
//    <#requirements#>
//}

class TextFieldTableViewCell: BaseTableViewCell, UITextFieldDelegate {

//    var delegate: TextFieldTableViewCellDelegate?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.red
        label.text = "ROLL NAME"
        label.alpha = 0
        label.font = Theme.Font.newRollTitleLabelFont!
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cellTextField: UITextField = {
        let textField = UITextField()
        //textField.backgroundColor = UIColor.green
        
        textField.placeholder = "ROLL NAME"
        textField.adjustsFontSizeToFitWidth = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    override func setupViews() {
    //cellTextField.delegate = self
        
    cellTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    addSubview(titleLabel)
    addSubview(cellTextField)
        
    titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    titleLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
      
        
    cellTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
    cellTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
    cellTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    cellTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
    selectionStyle = .none
    cellTextField.delegate = self

    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if cellTextField.text?.isEmpty == false {

            titleLabel.fadeIn()
            titleLabel.textColor = UIColor.orange
        }
        else {
            titleLabel.fadeOut()
        }
        
        //cellTextField.text =  cellTextField.text?.uppercased()
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
        return newLength <= 40
    }
    
    

}
