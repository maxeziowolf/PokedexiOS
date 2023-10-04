//
//  Pokemon.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 19/08/23.
//

import UIKit

class Pokemon {
    let id: Int
    let name: String
    let image: UIImage?
    var information: PokemonInformation

    init(id: Int, name: String, image: UIImage?, information: PokemonInformation) {
        self.id = id
        self.name = name
        self.image = image
        self.information = information
    }
}
