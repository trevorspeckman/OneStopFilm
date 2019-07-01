//
//  NewRollModel.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/1/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import Foundation

typealias NewRollTextFieldCellConfigurator = TableCellConfigurator<NewRollTextFieldTableViewCell, NewRollTextField>
typealias NewRollLabelCellConfigurator = TableCellConfigurator<NewRollLabelTableViewCell, String>

class NewRollModel {
    let items: [CellConfigurator] = [
        NewRollTextFieldCellConfigurator(item: NewRollTextField(text: "NEW ROLL", textLengthLimit: 40, keyboard: 0 )),
        NewRollLabelCellConfigurator(item: "FILM STOCK"),
        NewRollTextFieldCellConfigurator(item: NewRollTextField(text: "ASA", textLengthLimit: 4, keyboard: 1)),
        NewRollTextFieldCellConfigurator(item: NewRollTextField(text: "FRAME COUNT", textLengthLimit: 2, keyboard: 1)),
        NewRollLabelCellConfigurator(item: "CAMERA"),
        NewRollLabelCellConfigurator(item: "COLOR")
    ]

}
