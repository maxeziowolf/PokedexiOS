//
//  PokemonDetailUseCase.swift
//  PokedexiOS
//
//  Created by Maximiliano Ovando Ramírez on 04/10/23.
//

import Foundation
import ServiceCoordinator

final class PokemonDetailUseCase: GetPokemonDetailUseCase {
    // MARK: - Varibles
    private let network: PokemonNetworkRepository

    // MARK: - Especific create class
    public final class func create() -> GetPokemonDetailUseCase {
        let network = PokemonNetworkData()
        return PokemonDetailUseCase(network: network)
    }

    private init(network: PokemonNetworkRepository) {
        self.network = network
    }

    func execute(id: Int, completion: @escaping (Result<String, NetworkError>) -> Void) {
        let url = PokemonAPIConstans.getPokemonDetailURL(id: id + 1)

        Task {
            let result = await network.getPokemonDescription(url: url)

            switch result {
            case .success(let data):
                var description = ""
                data.flavorTextEntries?.forEach({ textEntry in
                    if let text = textEntry.flavorText, textEntry.language?.name == GlobalContent.shared.lenguageCode {
                        description += text + "\n\n"
                    }
                })
                description = description.isEmpty ? "No tiene informacion" : description
                completion(.success(description.clearText()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
