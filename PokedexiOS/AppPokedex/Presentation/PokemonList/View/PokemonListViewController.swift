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
    private var pokemonListView: PokemonListView
    private var model = PokemonListViewModel.create()
    private var susbcriptions: [AnyCancellable] = []
    private var loader: LoaderModalViewController?

    // MARK: - Create viewcontrolle
    final class func create() -> PokemonListViewController {
        let model = PokemonListViewModel.create()
        let viewController = PokemonListViewController(model: model)
        return viewController
    }

    private init(model: PokemonListViewModel) {
        self.model = model
        self.pokemonListView = PokemonListView.create(with: model)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Live cycle

    override func loadView() {
        view = pokemonListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        susbcriptions.append(model.$pokemonList.sink {[weak self] _ in
            self?.loader?.dismiss(animated: true)
            self?.pokemonListView.updatePokemonData()
        }
)
       pokemonListView.model = model

        susbcriptions.append(model.piplineErrorMessages.sink(receiveValue: {[weak self] message in
            let errorModal = ErrorModalViewController.create {
                self?.getPokemonList()
            }

            errorModal.viewError.messageLabel.text = message

            self?.loader?.dismiss(animated: false) {
                self?.present(errorModal, animated: true)
            }
        }))
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewDidAppear(_ animated: Bool) {
        getPokemonList()
    }

    private func setupUI() {
        title = "Pokedex"
        pokemonListView.setupFlowLayaotConfig(width: UIScreen.main.bounds.width)
        pokemonListView.navigationController = navigationController
    }

    func getPokemonList() {
        let loader = LoaderModalViewController.create()
        self.loader = loader
        present(loader, animated: true) { [weak self] in
            self?.model.getPokemonListInformacion()
        }
    }

}
