//
//  DetailFrameModel.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/2/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

typealias SliderTableViewCellConfigurator = TableCellConfigurator<SliderTableViewCell, LabelWithImage>

class DetailFrameModel {
    let items: [CellConfigurator] = [
        SliderTableViewCellConfigurator(item: LabelWithImage(icon: UIImage(named: "icon_log")!, labelText: "f/1.4")),
        SliderTableViewCellConfigurator(item: LabelWithImage(icon: UIImage(named: "icon_log")!, labelText: "f/1.4")),
        SliderTableViewCellConfigurator(item: LabelWithImage(icon: UIImage(named: "icon_log")!, labelText: "f/1.4")),
        SliderTableViewCellConfigurator(item: LabelWithImage(icon: UIImage(named: "icon_log")!, labelText: "f/1.4")),
SliderTableViewCellConfigurator(item: LabelWithImage(icon: UIImage(named: "icon_log")!, labelText: "f/1.4")),
NewRollTextFieldCellConfigurator(item: NewRollTextField(text: "NOTES", textLengthLimit: 40, keyboard: 0 ))
    ]
    
}
