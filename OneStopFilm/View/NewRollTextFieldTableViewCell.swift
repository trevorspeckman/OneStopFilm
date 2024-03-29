//
//  TextFieldTableViewCell.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 6/25/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit


protocol NewRollTextFieldTableViewCellDelegate {
    func textFieldDidEndEditing(text: String, cell: NewRollTextFieldTableViewCell)
    func textFieldDidChange(text: String?, cell: NewRollTextFieldTableViewCell)
}

class NewRollTextFieldTableViewCell: BaseTableViewCell, ConfigurableCell, UITextFieldDelegate {

    var value: String? {
        return cellTextField.text
    }
    
    var newRoll: NewRollTextField! {
        didSet{
            titleLabel.text = newRoll.text
            cellTextField.placeholder = newRoll.text
            if newRoll.keyboard == 0 {
                cellTextField.keyboardType = .default
            } else if newRoll.keyboard == 1 {
                cellTextField.keyboardType = .numberPad
            } else if newRoll.keyboard == 2 {
                cellTextField.keyboardType = .decimalPad
            }
            textLengthLimit = newRoll.textLengthLimit
            cellTextField.text = nil
            titleLabel.alpha = 0
        }
    }
    
    
    var delegate: NewRollTextFieldTableViewCellDelegate?
    
//MARK: Subview Initialization
    let titleLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.font = Theme.Font.newRollTitleLabelFont!
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cellTextField: UITextField = {
        let textField = UITextField()
        textField.adjustsFontSizeToFitWidth = true
        textField.textColor = Theme.current.textColor
        textField.clearButtonMode = .whileEditing
        

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
        
        
        cellTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        cellTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        cellTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        cellTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true


        selectionStyle = .none


    }
    

    
    
//    private func update(button: UIButton, image: UIImage?, color: UIColor) {
//        let image = (image ?? button.currentImage)?.withRenderingMode(.alwaysTemplate)
//        button.setImage(image, for: .normal)
//        button.setImage(image, for: .highlighted)
//        button.tintColor = color
//    }

    
//MARK: ConfigurableCell Protocol Methods
    func configure(data newRoll: NewRollTextField) {
        titleLabel.text = newRoll.text
        cellTextField.attributedPlaceholder =
            NSAttributedString(string: newRoll.text, attributes: [NSAttributedString.Key.foregroundColor: Theme.current.placeholderColor])
        //cellTextField.placeholder = newRoll.text
        if newRoll.keyboard == 0 {
            cellTextField.keyboardType = .default
        } else if newRoll.keyboard == 1 {
            cellTextField.keyboardType = .numberPad
        } else if newRoll.keyboard == 2 {
            cellTextField.keyboardType = .decimalPad
        }
        textLengthLimit = newRoll.textLengthLimit
        
    }
    
//MARK: TextField Delegate Methods
    @objc func textFieldDidChange(_ textField: UITextField) {
        if cellTextField.text?.isEmpty == false {

            titleLabel.fadeIn()
            titleLabel.textColor = Theme.current.tintColor
        }
        else {
            titleLabel.fadeOut()
        }
        cellTextField.text =  cellTextField.text?.uppercased()
        delegate?.textFieldDidChange(text: cellTextField.text, cell: self)
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if cellTextField.text?.isEmpty == false {
            titleLabel.textColor = Theme.current.tintColor
        }
        

    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        titleLabel.textColor = UIColor.gray
        if let text = cellTextField.text {
            delegate?.textFieldDidEndEditing(text: text, cell: self)
        }
    }

    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard let text = cellTextField.text else { return true }
//        let newLength = text.count + string.count - range.length
//        return newLength <= textLengthLimit
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text, let r = Range(range, in: oldText) else {
            return true
        }
        
        let newText = oldText.replacingCharacters(in: r, with: string)
        //let isNumeric = newText.isEmpty || (Double(newText) != nil)
        let numberOfDots = newText.components(separatedBy: ".").count - 1
        
        let numberOfDecimalDigits: Int
        if let dotIndex = newText.firstIndex(of: ".") {
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
        } else {
            numberOfDecimalDigits = 0
        }
        
        guard let text = cellTextField.text else { return true }
        let newLength = text.count + string.count - range.length
        
        return  numberOfDots <= 1 && numberOfDecimalDigits <= 1 && newLength <= textLengthLimit
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    

}
