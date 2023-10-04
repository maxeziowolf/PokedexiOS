//
//  PokemonAPINetwork.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 17/07/23.
//

import UIKit

struct PokemonAPIConstans {
    private static let baseURLAPI = "https://pokeapi.co/api/v2/"
    private static let pokemonListDataEndpoint = "pokemon?limit=40&offset=0"
    private static let pokemonDetailDataEndpoint = "pokemon-species/"

    public static func getPokemonListURL() -> String {
        return baseURLAPI + pokemonListDataEndpoint
    }

    public static func getPokemonDetailURL(id: Int) -> String {
        return baseURLAPI + pokemonDetailDataEndpoint + String(id)
    }
}
