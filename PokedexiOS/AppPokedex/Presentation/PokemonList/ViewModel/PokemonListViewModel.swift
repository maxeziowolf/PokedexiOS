//
//  PokemonListViewModel.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 18/08/23.
//

import UIKit
import Combine

// MARK: - Protocols of inputs
protocol PokemonListModelInput {
//    func didSearchListPokemonInfo ()
//    func didOpenPokemonDetail(with id: Int)
}

// MARK: - Protocols of outputs
protocol PokemonListModelOutput {
//    var pokemonInformation: PassthroughSubject<[Pokemon], Never> { get }
//    var errorInRequest: PassthroughSubject<String, Never> { get }
}

protocol PokemonListModelProtocols: PokemonListModelInput, PokemonListModelOutput { }

final class PokemonListViewModel: PokemonListModelProtocols {

    // Variables
//    var pokemonInformation: PassthroughSubject<[Pokemon], Never> = PassthroughSubject()
//    var errorInRequest: PassthroughSubject<String, Never> = PassthroughSubject()
//    var useCase = PokemonListUseCase()

}

extension PokemonListViewModel {
//    func didSearchListPokemonInfo() {
//        useCase.execute { [weak self] pokemons in
//            guard let pokemons = pokemons else {
//                self?.errorInRequest.send("No se obtuvo la informacion.")
//                return
//            }
//            self?.pokemonInformation.send(pokemons)
//        }
//    }
//
//    func didOpenPokemonDetail(with id: Int) {
//        print("")
//    }
}
