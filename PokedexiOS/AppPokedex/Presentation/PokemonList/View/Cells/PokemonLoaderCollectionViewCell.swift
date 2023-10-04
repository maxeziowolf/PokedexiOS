//
//  PokemonCollectionViewCell.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 14/08/23.
//

import UIKit
import SwiftUI

class PokemonLoaderCollectionViewCell: UICollectionViewCell {

    // MARK: - Identifier
    public static let identifier = "PokemonLoaderCollectionViewCell"

    // MARK: - UIComponets
    private lazy var cellContentView: UIView = {
        var view = UIView()
        view.backgroundColor = .defaultPokemonColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var contentLoadingStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private var pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = LocalizedKeys.GeneralTexts.loadingString
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.backgroundColor = .defaultPokemonColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var logoPokeballImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .pokeballLogo?.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.alpha = 0.5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.startRotationAnimation(animationDuration: 2)
        return imageView
    }()

    // MARK: - Inicializadores
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("")
    }

    // MARK: - UIConfiguration
    private func setupUI() {
        contentView.layer.cornerRadius = 20.0
        contentView.layer.masksToBounds = true
        setupView()
        setupConstrains()
    }

    private func setupView() {
        [cellContentView].forEach(contentView.addSubview)
        [contentLoadingStack].forEach(cellContentView.addSubview)
        [logoPokeballImage, pokemonNameLabel].forEach(contentLoadingStack.addArrangedSubview)
    }

    private func setupConstrains() {
        NSLayoutConstraint.activate([
            cellContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            contentLoadingStack.topAnchor.constraint(equalTo: cellContentView.topAnchor, constant: 10),
            contentLoadingStack.leadingAnchor.constraint(equalTo: cellContentView.leadingAnchor, constant: 10),
            contentLoadingStack.trailingAnchor.constraint(equalTo: cellContentView.trailingAnchor, constant: -10),
            contentLoadingStack.bottomAnchor.constraint(equalTo: cellContentView.bottomAnchor, constant: -10),

            logoPokeballImage.heightAnchor.constraint(equalTo: contentLoadingStack.heightAnchor, multiplier: 0.6)
        ])
    }

}

struct PokemonLoaderCollectionViewCell_Previews: PreviewProvider {

    static let widthSize = 200
    static let heightSize = 150

    static var previews: some View {
        ViewPreview {
            let view = PokemonLoaderCollectionViewCell(frame: CGRect(x: 0, y: 0, width: widthSize, height: heightSize))
            return view
        }
        .previewLayout(PreviewLayout.fixed(width: CGFloat(widthSize + 40), height: CGFloat(heightSize + 10)))
        .padding(5)
        .edgesIgnoringSafeArea(.all)
    }

}
