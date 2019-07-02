//
//  AddFilmPopUpModel.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/1/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import Foundation

typealias AddFilmTextFieldCellConfigurator = TableCellConfigurator<NewRollTextFieldTableViewCell, NewRollTextField>


class AddFilmPopUpModel {
    let items: [CellConfigurator] = [
        AddFilmTextFieldCellConfigurator(item: NewRollTextField(text: "BRAND", textLengthLimit: 20, keyboard: 0 )),
        AddFilmTextFieldCellConfigurator(item: NewRollTextField(text: "FILM NAME", textLengthLimit: 20, keyboard: 0))
    ]
    
}
