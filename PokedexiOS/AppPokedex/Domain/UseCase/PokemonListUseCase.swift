//
//  PokemonListUseCase.swift
//  PokedexiOS
//
//  Created by Maximiliano Ovando Ramírez on 24/09/23.
//

import ServiceCoordinator
import UIKit

final class PokemonListUseCase: GetPokemonListUseCase {

    // MARK: - Varibles
    private let network: PokemonNetworkRepository

    // MARK: - Especific create class
    public final class func create() -> GetPokemonListUseCase {
        let network = PokemonNetworkData()
        return PokemonListUseCase(network: network)
    }

    private init(network: PokemonNetworkRepository) {
        self.network = network
    }

    func execute(completion: @escaping (Result<[Pokemon], NetworkError>) -> Void) {

        Task(priority: .userInitiated) {
            let resultPokemons = await network.getPokemonList()

            switch resultPokemons {
            case .success(let listPokemons):
                let pokemonInformation = await getPokemonInformation(list: listPokemons)

                completion(pokemonInformation)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getPokemonInformation(list: [ResultData] ) async -> Result<[Pokemon], NetworkError> {

        let resultCollection = await withTaskGroup(of: Result<Pokemon, NetworkError>.self, returning: Result<[Pokemon], NetworkError>.self, body: { taskGroup in

            for data in list {
                if let url = data.url {

                    taskGroup.addTask {
                        let information = await self.network.getPokemonInformation(url: url)

                        switch information {
                        case .success(let information):

                            let typeColor = UIColor.getPokemonTypeColor(pokemonType: information.types?.first?.type?.name ?? "") ?? .gray

                            let pokemonImage = await self.getPokemonImage(stringURL: information.sprites?.other?.officialArtwork?.frontDefault)
                            let pokemonTypes = await self.getTypes(elements: information.types)

                            let id = information.id ?? 0
                            let name = information.name ?? "NA"
                            let height = information.height ?? 0
                            let weight = information.weight ?? 0
                            let baseExperience = information.baseExperience ?? 0

                            let pokemonInformation = PokemonInformation(description: "", height: height, weight: weight, baseExperience: baseExperience, evolutionChain: [], stats: [], colorType: typeColor, types: pokemonTypes)

                            let pokemon = Pokemon(id: id, name: name, image: pokemonImage, information: pokemonInformation)

                            return .success(pokemon)
                        case .failure(let error):
                            return .failure(error)
                        }

                    }

                }
            }

            var result = await taskGroup.reduce(into: [Pokemon]()) { partialResult, result in
                switch result {
                case .success(let pokemon):
                    partialResult.append(pokemon)
                case .failure:
                    break
                }
            }

            result = result.sorted(by: {$0.id < $1.id})

            return .success(result)

        })

        return resultCollection

    }

    private func getTypes(elements: [TypeElement]?) async -> [String] {
        guard let listElements = elements else {
            return []
        }

        let resultsTypes = await withTaskGroup(of: Result<PokemonTypeData, NetworkError>.self, returning: [String].self, body: { group in

            for data in listElements {
                if let url = data.type?.url {
                    group.addTask {
                        let resultType = await self.network.getPokemonTypeInformation(url: url)

                        switch resultType {
                        case .success(let type):
                            return .success(type)
                        case .failure(let error):
                            return .failure(error)
                        }
                    }
                }
            }

            let types = await group.reduce(into: [String](), { partialResult, result in
                switch result {
                case .success(let type ):
                    if let name = type.names?.first(where: {$0.language?.name == GlobalContent.shared.lenguageCode})?.name {
                        partialResult.append(name)
                    }
                case .failure:
                    break
                }
            })

            return types
        })

        return resultsTypes
    }

    private func getPokemonImage(stringURL: String?) async -> UIImage? {
        guard let stringURL = stringURL else {
            return nil
        }

        let resultImage = await network.getPokemonImage(url: stringURL)

        switch resultImage {
        case .success(let image):
            return image
        case .failure:
            return nil
        }
    }

}
