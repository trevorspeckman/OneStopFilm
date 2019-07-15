//
//  Reusable.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/13/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit


protocol Reusable {
    static var reuseIdentifier: String { get }

}




extension UITableViewCell: Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}




extension UICollectionViewCell: Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
    
    
extension UITableView {
    func register<T: UITableViewCell>(_ :T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
}


extension UICollectionView {
    func register<T: UICollectionViewCell>(_ :T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
}

    


