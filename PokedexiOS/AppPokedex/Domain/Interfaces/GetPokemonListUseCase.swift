//
//  GetPokemonListUseCase .swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 18/09/23.
//

import UIKit
import ServiceCoordinator

protocol GetPokemonListUseCase {
    func execute(completion: @escaping (Result<[Pokemon], NetworkError>) -> Void)
}
