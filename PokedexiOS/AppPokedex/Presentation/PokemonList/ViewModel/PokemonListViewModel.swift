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
    func getPokemonListInformacion()
}

// MARK: - Protocols of outputs
protocol PokemonListModelOutput {
    var pokemonList: [Pokemon] { get }
    var piplineErrorMessages: PassthroughSubject<String, Never> { get }
}

protocol PokemonListModelProtocols: PokemonListModelInput, PokemonListModelOutput { }

final class PokemonListViewModel: PokemonListModelProtocols {

    // MARK: - Variables
    @Published public var pokemonList: [Pokemon] = []
    public var piplineErrorMessages: PassthroughSubject<String, Never> = PassthroughSubject<String, Never>()
    private var useCase: GetPokemonListUseCase

    // MARK: - Create Functions
    final class func create() -> PokemonListViewModel {
        let useCase = PokemonListUseCase.create()
        return PokemonListViewModel(useCase: useCase)
    }

    private init(useCase: GetPokemonListUseCase) {
        self.useCase = useCase
    }

}

// MARK: - PokemonListModelOutput Implemented
extension PokemonListViewModel {
    func getPokemonListInformacion() {
        useCase.execute { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let list):
                    self?.pokemonList.append(contentsOf: list)
                case .failure(let error):
                    self?.piplineErrorMessages.send(error.localizedDescription)
                }
            }
        }
    }
}
