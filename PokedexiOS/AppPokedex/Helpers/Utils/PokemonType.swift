//
//  PokemonType.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 13/07/23.
//

import UIKit

enum PokemonType: String {
    case normal = "Normal"
    case fire = "Fire"
    case water = "Water"
    case grass = "Grass"
    case electric = "Electric"
    case ice = "Ice"
    case fighting = "Fighting"
    case poison = "Poison"
    case ground = "Ground"
    case flying = "Flying"
    case psychic = "Psychic"
    case bug = "Bug"
    case rock = "Rock"
    case ghost = "Ghost"
    case dark = "Dark"
    case dragon = "Dragon"
    case steel = "Steel"
    case fairy = "Fairy"
    case defaultPokemon = "default"
}

class PokemonTypes {

    public static func getPokemonTypeColor(pokemonType typeName: String) -> UIColor? {
        let type = PokemonType(rawValue: typeName) ?? .defaultPokemon

        let typeColorMapping: [PokemonType: UIColor] = [
            .normal: .normalPokemonColor!,
            .fire: .firePokemonColor!,
            .water: .waterPokemonColor!,
            .grass: .grassPokemonColor!,
            .electric: .electricPokemonColor!,
            .ice: .icePokemonColor!,
            .fighting: .fightingPokemonColor!,
            .poison: .poisonPokemonColor!,
            .ground: .groundPokemonColor!,
            .flying: .flyingPokemonColor!,
            .psychic: .psychicPokemonColor!,
            .bug: .bugPokemonColor!,
            .rock: .rockPokemonColor!,
            .ghost: .ghostPokemonColor!,
            .dark: .darkPokemonColor!,
            .dragon: .dragonPokemonColor!,
            .steel: .steelPokemonColor!,
            .fairy: .fairyPokemonColor!,
            .defaultPokemon: .defaultPokemonColor!
        ]

        return typeColorMapping[type]
    }

}
