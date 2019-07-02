//
//  PopupLauncher.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/1/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

class PopupLauncher: NSObject {
    
    var popup: BasePopUp?
    
    @objc func showPopup() {
        if let window = UIApplication.shared.keyWindow {
            
            popup?.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            popup?.cancelButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cancelTapped)))
            popup?.saveButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(saveTapped)))
            
            window.addSubview(popup!)
            popup?.frame = window.frame
            popup?.alpha = 0
            
            UIView.animate(withDuration: 0.5) {
                self.popup?.alpha = 1
            }
        }
        
    }
    
    @objc func cancelTapped() {
        UIView.animate(withDuration: 0.5) {
            self.popup?.alpha = 0
            self.popup?.endEditing(true)
        }
    }
    
    @objc func saveTapped() {
        UIView.animate(withDuration: 0.5) {
            self.popup?.alpha = 0
            self.popup?.endEditing(true)
        }
    }
    
    override init(){
        popup = nil
        super.init()
        
        
    }
    
}
