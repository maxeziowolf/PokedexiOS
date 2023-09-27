//
//  PokemonListView.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 14/08/23.
//

import UIKit
import SwiftUI

final class PokemonListView: UIView {

    public var model: PokemonListViewModel
    public var navigationController: UINavigationController?

    // MARK: - Componentes
    private var logoPokeballImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .pokeballLogo?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .defaultPokemonColor
        imageView.alpha = 0.5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let flowLayoutCollectionView: UICollectionViewFlowLayout = {
        let layaout = UICollectionViewFlowLayout()
        layaout.scrollDirection = .vertical
        layaout.sectionInset = .init(top: 5, left: 5, bottom: 5, right: 5)
        layaout.minimumInteritemSpacing = 10
        layaout.minimumLineSpacing = 10
        return layaout
    }()

    private let characterCollectionview: UICollectionView = {
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionview.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
        collectionview.register(PokemonLoaderCollectionViewCell.self, forCellWithReuseIdentifier: PokemonLoaderCollectionViewCell.identifier)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.backgroundColor = .clear
        return collectionview
    }()

    // MARK: - Inicializadores

    final class func create(with model: PokemonListViewModel) -> PokemonListView {
        return PokemonListView(frame: .zero, with: model)
    }

    private init(frame: CGRect, with model: PokemonListViewModel) {
        self.model = model
        super.init(frame: frame)
        backgroundColor = .white
        clipsToBounds = true
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIConfiguration
    private func setup() {
        addSubviews()
        configureConstraints()
    }

    private func addSubviews() {
        [logoPokeballImage, characterCollectionview].forEach(addSubview)
    }

    private func configureConstraints() {

        NSLayoutConstraint.activate([

            logoPokeballImage.centerYAnchor.constraint(equalTo: topAnchor, constant: 75),
            logoPokeballImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 100),
            logoPokeballImage.heightAnchor.constraint(equalToConstant: 250),
            logoPokeballImage.widthAnchor.constraint(equalTo: logoPokeballImage.heightAnchor, multiplier: 1),

            characterCollectionview.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            characterCollectionview.leadingAnchor.constraint(equalTo: leadingAnchor),
            characterCollectionview.trailingAnchor.constraint(equalTo: trailingAnchor),
            characterCollectionview.bottomAnchor.constraint(equalTo: bottomAnchor)

        ])

        characterCollectionview.dataSource = self
        characterCollectionview.delegate = self

    }

    // MARK: - Functions
    public func setupFlowLayaotConfig(width: CGFloat) {

        let widthSize = (width - 20)/2
        let heightSize = (width)*(12/40)

        flowLayoutCollectionView.itemSize = .init(width: widthSize, height: heightSize)

        characterCollectionview.collectionViewLayout = flowLayoutCollectionView
    }

    public func updatePokemonData() {
        characterCollectionview.reloadData()
    }

}

// MARK: - UICollectionViewDataSource
extension PokemonListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.pokemonList.count < GlobalContent.shared.totalCountPokemons ? model.pokemonList.count + 6 : Int.max
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let isLimit = (GlobalContent.shared.totalCountPokemons == model.pokemonList.count)
        let totalPokemons = model.pokemonList.count
        let identifier = indexPath.row < totalPokemons || isLimit ? PokemonCollectionViewCell.identifier : PokemonLoaderCollectionViewCell.identifier

        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)

        if (indexPath.row < totalPokemons || isLimit) && !(model.pokemonList.isEmpty) {
            let cellPokemon = cell as? PokemonCollectionViewCell
            let pokemon = model.pokemonList[indexPath.row % totalPokemons]
            cellPokemon?.setPokemonData(data: pokemon)
        }

        if indexPath.row == (model.pokemonList.count - 6) && GlobalContent.shared.totalCountPokemons > totalPokemons {
            model.getPokemonListInformacion()
        }

        return cell
    }

}

extension PokemonListView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

//        let viewController = PokemonDetailViewController.create(pokemons: pokemons, index: indexPath.row, delegate: self)
//
//        navigationController?.pushViewController(viewController, animated: true)

    }
}

// extension PokemonListView: UpdatePositionProtocol {
//    func updatePosition(index: Int) {
//        characterCollectionview.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredVertically, animated: true)
//    }
// }

struct PokemonListView_Previews: PreviewProvider {
   static var previews: some View {
       ViewControllerPreview {
           PokemonListViewController.create()
       }
   }
}
