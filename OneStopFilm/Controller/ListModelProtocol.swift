//
//  ListModelProtocol.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/15/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol ListModelProtocol {
    var entityName : String { get }
    var searchBarPlaceholderText: String { get }
    var sortDescriptors : [NSSortDescriptor]? { get }
    var attributeNamesToFilter: [String] { get }
    var modelArray: [NewRollTextField] { get }
    var addItemPopup: BasePopupTest { get }
    func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath, with fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>)
    func saveData(context: NSManagedObjectContext)
    var needsToChangeNavBarBackground: Bool { get }
}


