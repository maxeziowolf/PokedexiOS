//
//  PokemonDetailViewController.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 12/07/23.
//

import UIKit
import Combine

protocol UpdatePositionProtocol {
    func updatePosition(index: Int)
}

class PokemonDetailViewController: UIViewController {

    // MARK: - Variables
    public var pokemonDetailView: PokemonDetailView
    private var viewModel: PokemonDetailViewModel
    private var anyCancellave: [AnyCancellable]
    private var pokemons: [Pokemon]
    private var index: Int
    private var delegate: UpdatePositionProtocol?

    // MARK: - Created function
    final class func create(pokemons: [Pokemon], index: Int, delegate: UpdatePositionProtocol? = nil) -> PokemonDetailViewController {
        let viewController = PokemonDetailViewController(anyCancellave: [], pokemons: pokemons, index: index, delegate: delegate)
        return viewController
    }

    private init(pokemonDetailView: PokemonDetailView = PokemonDetailView(), viewModel: PokemonDetailViewModel = PokemonDetailViewModel(), anyCancellave: [AnyCancellable], pokemons: [Pokemon], index: Int!, delegate: UpdatePositionProtocol? = nil) {
        self.pokemonDetailView = pokemonDetailView
        self.viewModel = viewModel
        self.anyCancellave = anyCancellave
        self.pokemons = pokemons
        self.index = index
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cicle
    override func loadView() {
        view = pokemonDetailView

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        updateInfo()

        if pokemons[index].information.description.isEmpty {
            viewModel.didSearchPokemonInfo(pokemonID: index)
        }

        pokemonDetailView.addGesture(viewController: self, beforeSelected: #selector(updateBefore), nextSelected: #selector(updateNext), swipeSeleted: #selector(updateSwipe))
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false

        navigationController?.navigationBar.isHidden = false
    }

    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.updatePosition(index: index)
    }

    // MARK: - Updete information functions
    private func updateInfo() {
        let pokemon = pokemons[(index % pokemons.count)]
        pokemonDetailView.setPokemonInformation(pokemonData: pokemon)
        if pokemon.information.description.isEmpty {
            viewModel.didSearchPokemonInfo(pokemonID: index)
        }

        if (index - 1) >= 0 {
            pokemonDetailView.setBeforePokemon(before: pokemons[(index % pokemons.count) - 1].image)
        } else {
            pokemonDetailView.setBeforePokemon(before: nil)
        }

        if (index + 1) < pokemons.count {
            pokemonDetailView.setNextPokemon(next: pokemons[(index % pokemons.count) + 1].image)
        } else {
            pokemonDetailView.setNextPokemon(next: nil)
        }
    }

    private func bind(to viewModel: PokemonDetailViewModel) {
        let pokemonInfoObserver = viewModel.pokemonInformation.sink { values in
            DispatchQueue.main.async { [weak self] in
                let pokemon = self?.pokemons[values.id]
                pokemon?.information.description = values.description

                if let pokemon = pokemon, values.id == self?.index {
                    self?.pokemonDetailView.setPokemonInformation(pokemonData: pokemon)
                }
            }
        }

        anyCancellave.append(pokemonInfoObserver)
    }

    // MARK: - Gesture functions
    @objc
    func updateSwipe(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.direction == .left {
            updateNext()
        } else if recognizer.direction == .right {
            updateBefore()
        }
    }

    @objc
    func updateNext() {
        if (index + 1) < pokemons.count {
            index += 1
            updateInfo()
        }
    }

    @objc
    func updateBefore() {
        if (index - 1) >= 0 {
            index -= 1
            updateInfo()
        }
    }

}
