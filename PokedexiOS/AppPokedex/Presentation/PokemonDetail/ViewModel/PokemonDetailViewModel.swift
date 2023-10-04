//
//  PokemonDetailViewModel.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 16/07/23.
//

import UIKit
import Combine

 // MARK: - Protocolos
 protocol PokemonDetailModelInput {
    func didSearchPokemonInfo (pokemonID id: Int)
    func didSelectedNextPokemon (pokemonID id: Int)
    func didSelectedBeforePokemon (pokemonID id: Int)
 }

 protocol PokemonDetailOutput {
    var pokemonInformation: PassthroughSubject<(description: String, id: Int), Never> { get }
 }

 protocol PokemonDetailViewModelProtocols: PokemonDetailModelInput, PokemonDetailOutput { }

 // MARK: - ViewModel
 final class PokemonDetailViewModel: PokemonDetailViewModelProtocols {

    // MARK: - Values
     private let  pokemonDetailUseCase = PokemonDetailUseCase.create()

    // MARK: - OUTPUT Values
     var pokemonInformation: PassthroughSubject<(description: String, id: Int), Never> = PassthroughSubject()

    // MARK: - Functions
    private func loadPokemonInformation(pokemonID id: Int) {

        pokemonDetailUseCase.execute(id: id) { result in
            switch result {
            case .success(let data):
                self.pokemonInformation.send((data, id))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }

 }

 // MARK: - FunctionsExtension
 extension PokemonDetailViewModel {

    func didSearchPokemonInfo(pokemonID id: Int) {
        loadPokemonInformation(pokemonID: id)
    }

    func didSelectedNextPokemon(pokemonID id: Int) {
        loadPokemonInformation(pokemonID: (id + 1))
    }

    func didSelectedBeforePokemon(pokemonID id: Int) {
        loadPokemonInformation(pokemonID: (id - 1))
    }

 }
