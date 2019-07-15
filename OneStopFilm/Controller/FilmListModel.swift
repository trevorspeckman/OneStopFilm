//
//  FilmListModel.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 6/27/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit
import CoreData

class FilmListModel: ListModelProtocol {
    
    var entityName: String = "Film"
    var searchBarPlaceholderText: String = "SEARCH FILMS"
    var sortDescriptors: [NSSortDescriptor]? = [NSSortDescriptor(key: "brand", ascending: true), NSSortDescriptor(key: "name", ascending: true)]
    
    var attributeNamesToFilter: [String] = ["brand","name"]
    
    var modelArray: [NewRollTextField] = [
        NewRollTextField(text: "BRAND", textLengthLimit: 20, keyboard: 0),
        NewRollTextField(text: "FILM NAME", textLengthLimit: 20, keyboard: 0)
    ]
    
    lazy var addItemPopup: BasePopupTest = BasePopupTest(model: modelArray)
    
    func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath, with fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>) {
        let film = fetchedResultsController.object(at: indexPath) as! Film
        cell.textLabel?.text = "\(film.brand ?? "") \(film.name ?? "")"
    }
    
    func saveData(context: NSManagedObjectContext) {
        let newFilm = Film(context: context)
        newFilm.brand = addItemPopup.typedText[0]
        newFilm.name =  addItemPopup.typedText[1]
    }
    
    var needsToChangeNavBarBackground: Bool = false
    
}
