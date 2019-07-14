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
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T  {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not deque cell")
        }
        return cell
    }
}


extension UICollectionView {
    func register<T: UICollectionViewCell>(_ :T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T  {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not deque cell")
        }
        return cell
    }
}

    


