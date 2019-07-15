//
//  CameraListModel.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 6/27/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit
import CoreData

class CameraListModel: ListModelProtocol {
    
    var entityName: String = "Camera"
    var searchBarPlaceholderText: String = "SEARCH CAMERAS"
    var sortDescriptors: [NSSortDescriptor]? = [NSSortDescriptor(key: "brand", ascending: true), NSSortDescriptor(key: "name", ascending: true)]
    
    var attributeNamesToFilter: [String] = ["brand","name"]
    
    var modelArray: [NewRollTextField] = [
    NewRollTextField(text: "BRAND", textLengthLimit: 20, keyboard: 0),
    NewRollTextField(text: "CAMERA NAME", textLengthLimit: 20, keyboard: 0)
    ]
    
    lazy var addItemPopup: BasePopupTest = BasePopupTest(model: modelArray)
    
    func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath, with fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>) {
        let camera = fetchedResultsController.object(at: indexPath) as! Camera
        cell.textLabel?.text = "\(camera.brand ?? "") \(camera.name ?? "")"
    }
    
    func saveData(context: NSManagedObjectContext) {
        let newCamera = Camera(context: context)
        newCamera.brand = addItemPopup.typedText[0]
        newCamera.name =  addItemPopup.typedText[1]
    }
    
    var needsToChangeNavBarBackground: Bool = false
}
