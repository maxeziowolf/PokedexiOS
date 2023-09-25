//
//  PokemonData.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 12/07/23.
//
import Foundation

// MARK: - PokemonData
struct PokemonData: Codable {
    let baseExperience: Int?
    let forms: [Species]?
    let height: Int?
    let id: Int?
    let name: String?
    let order: Int?
    let species: Species?
    let sprites: Sprites?
    let stats: [Stat]?
    let types: [TypeElement]?
    let weight: Int?

    enum CodingKeys: String, CodingKey {
        case baseExperience = "base_experience"
        case forms
        case height
        case id
        case name, order
        case species, sprites, stats, types, weight
    }
}

// MARK: - Species
struct Species: Codable {
    let name: String?
    let url: String?
}

// MARK: - Sprites
class Sprites: Codable {
    let other: Other?
}

// MARK: - OfficialArtwork
struct OfficialArtwork: Codable {
    let frontDefault, frontShiny: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}

// MARK: - Other
struct Other: Codable {
    let officialArtwork: OfficialArtwork?

    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

// MARK: - Stat
struct Stat: Codable {
    let baseStat, effort: Int?
    let stat: Species?

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int?
    let type: Species?
}

// MARK: - PokemonDataWrapper
class PokemonDataWrapper {
    let data: PokemonData

    init(data: PokemonData) {
        self.data = data
    }
}
