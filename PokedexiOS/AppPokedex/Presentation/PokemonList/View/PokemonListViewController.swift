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
    public var pokemonListView: PokemonListView
    private var model: PokemonListViewModel
    private var susbcriptions: [AnyCancellable]
    private var loader: LoaderModalViewController?
    private var oneTime: Bool
    private let transitionManager = TransitionManager(duration: 0.3)

    // MARK: - Create viewcontrolle
    final class func create() -> PokemonListViewController {
        let model = PokemonListViewModel.create()
        let viewController = PokemonListViewController(model: model)
        return viewController
    }

    private init(model: PokemonListViewModel) {
        self.model = model
        self.pokemonListView = PokemonListView.create(with: model)
        self.susbcriptions = []
        self.oneTime = true
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Live cycle

    override func loadView() {
        view = pokemonListView
        pokemonListView.model = model
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        subscriptions()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewDidAppear(_ animated: Bool) {
        if oneTime {
            oneTime.toggle()
            getPokemonList()
        }
    }

    // MARK: - UI Configuration
    private func setupUI() {
        title = "Pokedex"
        pokemonListView.setupFlowLayaotConfig(width: UIScreen.main.bounds.width)
        pokemonListView.navigationController = navigationController
        transitionManager.navigationBar = navigationController?.navigationBar
        navigationController?.delegate = transitionManager
    }

    private func subscriptions() {
        let pokemonListSubscription = model.$pokemonList.sink {[weak self] _ in
            self?.loader?.dismiss(animated: true)
            self?.pokemonListView.updatePokemonData()
        }

        let errorMessagesSubscription = model.piplineErrorMessages.sink { [weak self] message in
            let errorModal = ErrorModalViewController.create {
                self?.getPokemonList()
            }

            errorModal.viewError.messageLabel.text = message

            self?.loader?.dismiss(animated: false) {
                self?.present(errorModal, animated: true)
            }
        }

        [pokemonListSubscription, errorMessagesSubscription].forEach({susbcriptions.append($0)})

    }

    private func getPokemonList() {
        let loader = LoaderModalViewController.create()
        self.loader = loader
        present(loader, animated: true) { [weak self] in
            self?.model.getPokemonListInformacion()
        }
    }

}
