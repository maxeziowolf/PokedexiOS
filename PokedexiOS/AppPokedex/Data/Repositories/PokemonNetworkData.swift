//
//  RemotePokemonListData.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 18/08/23.
//

import UIKit
import ServiceCoordinator

final class PokemonNetworkData: PokemonNetworkRepository {

    // MARK: - Cache data
    private var nextPage: String = ""
    private var cacheManger = CacheManager.shared

    // MARK: - Functions for optain information
    public func getPokemonList() async -> Result<[ResultData], NetworkError> {
        let url = nextPage.isEmpty ? PokemonAPIConstans.getPokemonListURL() : nextPage

        let result: ServiceStatus<PokemonListData?> = await ServiceCoordinator.shared.sendRequest(url: url)

        switch result {
        case .success(data: let data):
            GlobalContent.shared.totalCountPokemons = data?.count ?? 0
            nextPage = data?.next ?? "No more information"
            if let list = data?.results {
                return .success(list)
            } else {
                return .failure(.notFound)
            }
        case .failed(error: let error):
            return .failure(error)
        case .information(code: let code):
            return .failure(.otherCode(code: code))
        }

    }

    func getPokemonInformation(url stringURL: String) async -> Result<PokemonData, NetworkError> {
        if let infoCached = cacheManger.getPokemonInformation(forKey: stringURL)?.data {
            return .success(infoCached)
        } else {
            let result: ServiceStatus<PokemonData?> = await ServiceCoordinator.shared.sendRequest(url: stringURL)

            switch result {
            case .success(data: let data):
                if let data = data {
                    return .success(data)
                } else {
                    return .failure(.notFound)
                }
            case .failed(error: let error):
                return .failure(error)
            case .information(code: let code):
                return .failure(.otherCode(code: code))
            }
        }
    }

    func getPokemonTypeInformation(url stringURL: String) async -> Result<PokemonTypeData, NetworkError> {
        if let infoCached = cacheManger.getPokemonType(forKey: stringURL)?.data {
            return .success(infoCached)
        } else {
            let result: ServiceStatus<PokemonTypeData?> = await ServiceCoordinator.shared.sendRequest(url: stringURL)

            switch result {
            case .success(data: let data):
                if let data = data {
                    return .success(data)
                } else {
                    return .failure(.notFound)
                }
            case .failed(error: let error):
                return .failure(error)
            case .information(code: let code):
                return .failure(.otherCode(code: code))
            }
        }
    }

    func getPokemonDescription(url stringURL: String) async -> Result<PokemonDescriptionData, NetworkError> {
        if let infoCached = cacheManger.getPokemonDescriptionData(forKey: stringURL)?.data {
            return .success(infoCached)
        } else {
            let result: ServiceStatus<PokemonDescriptionData?> = await ServiceCoordinator.shared.sendRequest(url: stringURL)

            switch result {
            case .success(data: let data):
                if let data = data {
                    return .success(data)
                } else {
                    return .failure(.notFound)
                }
            case .failed(error: let error):
                return .failure(error)
            case .information(code: let code):
                return .failure(.otherCode(code: code))
            }
        }
    }

    func getPokemonImage(url stringURL: String) async -> Result<UIImage, NetworkError> {
        if let infoCached = cacheManger.getPokemonImage(forKey: stringURL) {
            return .success(infoCached)
        } else {
            let result: ServiceStatus<Data?> = await ServiceCoordinator.shared.sendRequest(url: stringURL)

            switch result {
            case .success(data: let data):
                if let data = data, let image = UIImage(data: data) {
                    self.cacheManger.cachePokemonImage(image, forKey: stringURL)
                    return .success(image)
                } else {
                    return .failure(.notFound)
                }
            case .failed(error: let error):
                return .failure(error)
            case .information(code: let code):
                return .failure(.otherCode(code: code))
            }
        }
    }

}
