//
//  PokemonListData.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 15/08/23.
//
import Foundation

// MARK: - PokemonList
struct PokemonListData: Codable {
    let count: Int?
    let previous: String?
    let next: String?
    let results: [ResultData]?
}

// MARK: - Result
struct ResultData: Codable {
    let name: String?
    let url: String?
}
