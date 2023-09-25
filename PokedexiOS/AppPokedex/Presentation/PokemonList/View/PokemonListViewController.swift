//
//  PokemonListViewController.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 14/08/23.
//

import UIKit
import Combine

class PokemonListViewController: UIViewController {

    // MARK: - Variables
    private var pokemonListView = PokemonListView()
//    private var model = PokemonListViewModel()
//    private var susbcriptions: [AnyCancellable] = []
//    private var loader: LoaderModalViewController?

    final class func create() -> PokemonListViewController {
        let viewController = PokemonListViewController()
        return viewController
    }

    override func loadView() {
        view = pokemonListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokedex"

        pokemonListView.setupFlowLayaotConfig(width: UIScreen.main.bounds.width)
        pokemonListView.navigationController = navigationController
        
        PokemonListUseCase.create().execute {[weak self] result in
            switch result {
                
            case .success(let pokemons):
                DispatchQueue.main.async {
                    self?.pokemonListView.updatePokemonData(data: pokemons)
                }
            case .failure:
                print("error")
            }
        }
        
//        pokemonListView.model = model

//        getPokemonList()

//        susbcriptions.append(model.pokemonInformation.sink {[weak self]  pokemons in
//            self?.loader?.dismiss(animated: true)
//            self?.pokemonListView.updatePokemonData(data: pokemons)
//        })
//
//        susbcriptions.append(model.errorInRequest.sink {[weak self]  error in
//            let errorModal = ErrorModalViewController.create {
//                self?.getPokemonList()
//            }
//            errorModal.viewError.messageLabel.text = error
//
//            self?.loader?.dismiss(animated: false) {
//                self?.present(errorModal, animated: true)
//            }
//        })
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }

//    func getPokemonList() {
//        let loader = LoaderModalViewController.create()
//        self.loader = loader
//        present(loader, animated: true) {
//            self.model.didSearchListPokemonInfo()
//        }
//    }

}
