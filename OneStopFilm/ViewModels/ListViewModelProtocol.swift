//
//  FilmViewModelProtocol.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/14/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import Foundation
import CoreData

protocol ListViewModelProtocol {
    associatedtype T: NSFetchRequestResult
    var fetchedResultsController: NSFetchedResultsController<T> { get }
    func saveItems()
    func loadItems()
    
}
