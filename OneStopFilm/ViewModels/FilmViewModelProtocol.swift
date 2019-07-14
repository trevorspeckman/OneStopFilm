//
//  FilmViewModelProtocol.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/14/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import Foundation

protocol FilmViewModelProtocol {
    var attributeNames: [String] { get }
    var isSearching: Bool { get }
    var isAdding: Bool { get }
    func saveItems()
    func loadItems()
    
}
