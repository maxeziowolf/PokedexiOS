//
//  PokemonType.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 10/08/23.
//
import Foundation

// MARK: - PokemonType
struct PokemonTypeData: Codable {
    let id: Int?
    let name: String?
    let names: [NameType]?

    enum CodingKeys: String, CodingKey {
        case id, name, names
    }
}

// MARK: - Name
struct NameType: Codable {
    let language: Generation?
    let name: String?
}

// MARK: - Generation
struct Generation: Codable {
    let name: String?
    let url: String?
}

// MARK: - PokemonTypeWrapper
class PokemonTypeWrapper {
    let data: PokemonTypeData

    init(data: PokemonTypeData) {
        self.data = data
    }
}
