//
//  GetPokemonDetailUseCase.swift
//  PokedexiOS
//
//  Created by Maximiliano Ovando Ramírez on 04/10/23.
//

import Foundation
import ServiceCoordinator

protocol GetPokemonDetailUseCase {
    func execute(id: Int, completion: @escaping (Result<String, NetworkError>) -> Void)
}
