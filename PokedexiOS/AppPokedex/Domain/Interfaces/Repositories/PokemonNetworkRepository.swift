//
//  PokemonNetworkRepository.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 19/08/23.
//

import UIKit
import ServiceCoordinator

protocol PokemonNetworkRepository {
    func getPokemonList() async -> Result<[ResultData], NetworkError>
    func getPokemonInformation(url stringURL: String) async -> Result<PokemonData, NetworkError>
    func getPokemonTypeInformation(url stringURL: String) async -> Result<PokemonTypeData, NetworkError>
    func getPokemonDescription(url stringURL: String) async -> Result<PokemonDescriptionData, NetworkError>
    func getPokemonImage(url stringURL: String) async -> Result<UIImage, NetworkError>
}
