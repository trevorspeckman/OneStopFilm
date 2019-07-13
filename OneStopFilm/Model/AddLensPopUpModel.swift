//
//  AddLensPopUpModel.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/12/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import Foundation

typealias AddLensTextFieldCellConfigurator = TableCellConfigurator<NewRollTextFieldTableViewCell, NewRollTextField>


class AddLensPopUpModel {
    let items: [CellConfigurator] = [
        AddFilmTextFieldCellConfigurator(item: NewRollTextField(text: "BRAND", textLengthLimit: 20, keyboard: 0 )),
        AddFilmTextFieldCellConfigurator(item: NewRollTextField(text: "FOCAL LENGTH", textLengthLimit: 3, keyboard: 1)),
        AddFilmTextFieldCellConfigurator(item: NewRollTextField(text: "MIN APERATURE", textLengthLimit: 4, keyboard: 2)),
        AddFilmTextFieldCellConfigurator(item: NewRollTextField(text: "MAX APERATURE", textLengthLimit: 4, keyboard: 2))
    ]
}
