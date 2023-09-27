//
//  PokemonInformation.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 19/08/23.
//

import UIKit

struct PokemonInformation {
    var description: String
    let height: Int
    let weight: Int
    let baseExperience: Int
    var evolutionChain: [(in: Pokemon, to: Pokemon)]
    var stats: [PokemonStat]
    let colorType: UIColor
    let types: [String]
}
