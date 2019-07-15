//
//  LensListModel.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/15/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit
import CoreData

class LensListModel: ListModelProtocol {
    
    


    var entityName: String = "Lens"
    var searchBarPlaceholderText: String = "SEARCH LENSES"
    var sortDescriptors: [NSSortDescriptor]? = [NSSortDescriptor(key: "brand", ascending: true), NSSortDescriptor(key: "focalLength", ascending: true)]
    
    var attributeNamesToFilter: [String] = ["brand","focalLength"]
    
    var modelArray: [NewRollTextField] = [
        NewRollTextField(text: "BRAND", textLengthLimit: 20, keyboard: 0),
        NewRollTextField(text: "FOCAL LENGTH (mm)", textLengthLimit: 3, keyboard: 1),
        NewRollTextField(text: "MIN APERATURE", textLengthLimit: 4, keyboard: 2),
        NewRollTextField(text: "MAX APERATURE", textLengthLimit: 4, keyboard: 2)
    ]
    
    lazy var addItemPopup: BasePopupTest = BasePopupTest(model: modelArray)
    
    func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath, with fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>) {
        let lens = fetchedResultsController.object(at: indexPath) as! Lens
        
        cell.textLabel?.text = "\(lens.brand ?? "") \(lens.focalLength)mm"
        cell.detailTextLabel?.text = "(f/\(lens.minAperature) - f/\(lens.maxAperature))"
        cell.detailTextLabel?.textColor = Theme.current.subtitleTextColor
    }
    
    
    func saveData(context: NSManagedObjectContext) {
        let newLens = Lens(context: context)
        newLens.brand = addItemPopup.typedText[0]
        newLens.focalLength = Int16(addItemPopup.typedText[1]!)!
        newLens.minAperature = Float(addItemPopup.typedText[2]!)!
        newLens.maxAperature = Float(addItemPopup.typedText[3]!)!
    }
    
    var needsToChangeNavBarBackground: Bool = true
    
    
}
