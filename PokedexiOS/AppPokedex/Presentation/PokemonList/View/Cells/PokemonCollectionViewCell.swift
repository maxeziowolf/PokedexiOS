//
//  PokemonCollectionViewCell.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 14/08/23.
//
import UIKit
import SwiftUI
import Combine

class PokemonCollectionViewCell: UICollectionViewCell {

    // MARK: - Identifier
    public static let identifier = "PokemonCollectionViewCell"
    private var cacelation: AnyCancellable?
    public var pokemonColor: UIColor? = .waterPokemonColor {
        didSet {
            cellContentView.backgroundColor = pokemonColor
            pokemonNameLabel.backgroundColor = pokemonColor
            pokemonIDLabel.backgroundColor = pokemonColor
        }
    }

    // MARK: - UIComponets
    private lazy var cellContentView: UIView = {
        var view = UIView()
        view.backgroundColor = pokemonColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var headerPokemonInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .fillProportionally
        stack.alignment = .bottom
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

     lazy var pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = LocalizedKeys.GeneralTexts.dummyPokemonName
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.backgroundColor = pokemonColor
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var pokemonIDLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = LocalizedKeys.GeneralTexts.dummyID
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.textAlignment = .right
        label.backgroundColor = pokemonColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var contentPokemonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .fillEqually
        stack.alignment = .top
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private var tagsPokemonInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillEqually
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    var pokemonImageContent: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var logoPokeballImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .pokeballLogo?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
        imageView.alpha = 0.5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    public var pokemonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .pokemonDummy?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func prepareForReuse() {
        cacelation = nil
    }

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
        [headerPokemonInfoStack, contentPokemonStack].forEach(cellContentView.addSubview)
        [pokemonNameLabel, pokemonIDLabel].forEach(headerPokemonInfoStack.addArrangedSubview)
        [tagsPokemonInfoStack, pokemonImageContent].forEach(contentPokemonStack.addArrangedSubview)
        [logoPokeballImage, pokemonImage].forEach(pokemonImageContent.addSubview)
    }

    private func setupConstrains() {
        NSLayoutConstraint.activate([
            cellContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            headerPokemonInfoStack.topAnchor.constraint(equalTo: cellContentView.topAnchor, constant: 10),
            headerPokemonInfoStack.leadingAnchor.constraint(equalTo: cellContentView.leadingAnchor, constant: 10),
            headerPokemonInfoStack.trailingAnchor.constraint(equalTo: cellContentView.trailingAnchor, constant: -10),
            headerPokemonInfoStack.heightAnchor.constraint(equalToConstant: 20),

            contentPokemonStack.topAnchor.constraint(equalTo: headerPokemonInfoStack.bottomAnchor, constant: 10),
            contentPokemonStack.leadingAnchor.constraint(equalTo: cellContentView.leadingAnchor, constant: 10),
            contentPokemonStack.trailingAnchor.constraint(equalTo: cellContentView.trailingAnchor, constant: -10),
            contentPokemonStack.bottomAnchor.constraint(equalTo: cellContentView.bottomAnchor, constant: -10),

            logoPokeballImage.topAnchor.constraint(equalTo: pokemonImageContent.topAnchor, constant: 5),
            logoPokeballImage.leadingAnchor.constraint(equalTo: pokemonImageContent.leadingAnchor, constant: 5),
            logoPokeballImage.trailingAnchor.constraint(equalTo: pokemonImageContent.trailingAnchor, constant: 20),
            logoPokeballImage.bottomAnchor.constraint(equalTo: pokemonImageContent.bottomAnchor, constant: 20),

            pokemonImage.topAnchor.constraint(equalTo: pokemonImageContent.topAnchor, constant: -5),
            pokemonImage.leadingAnchor.constraint(equalTo: pokemonImageContent.leadingAnchor, constant: -5),
            pokemonImage.trailingAnchor.constraint(equalTo: pokemonImageContent.trailingAnchor, constant: 5),
            pokemonImage.bottomAnchor.constraint(equalTo: pokemonImageContent.bottomAnchor, constant: 5),

            pokemonIDLabel.widthAnchor.constraint(equalTo: headerPokemonInfoStack.widthAnchor, multiplier: 0.25)
        ])
    }

    // MARK: - Funtions
    public func setPokemonData(data: Pokemon) {
        // Informacion de cabecera
        pokemonNameLabel.text = data.name.capitalized
        pokemonIDLabel.text = data.id.getNumberWithFormtat()

        // Informacion de los tipos
        let types = data.information.types
        setTypesInfo(pokemonTypes: types)

        // Image y fondo
        pokemonImage.image = data.image?.compressImage() ?? .pokemonDummy?.withRenderingMode(.alwaysTemplate).withTintColor(.black)
        pokemonColor = data.information.colorType

        // Contraste en textos
        [pokemonNameLabel, pokemonIDLabel].forEach({$0.textColor = .textColor(for: pokemonColor)})
        tagsPokemonInfoStack.subviews.forEach { view in
            if let labelTag = view.subviews.first as? UILabel {
                labelTag.textColor = .textColor(for: pokemonColor)
            }
        }
    }

    private func setTypesInfo(pokemonTypes types: [String]) {
        tagsPokemonInfoStack.subviews.forEach({$0.removeFromSuperview()})

        let tags: [UIView] = types.compactMap({ type in
            return .getTagView(type: type)
        })

        tags.forEach(tagsPokemonInfoStack.addArrangedSubview)
    }

}

struct CharacterCollectionViewCell_Previews: PreviewProvider {
    static let widthSize = 200
    static let heightSize = 150

    static var previews: some View {
        ViewPreview {
            let view = PokemonCollectionViewCell(frame: CGRect(x: 0, y: 0, width: widthSize, height: heightSize))
            return view
        }
        .previewLayout(PreviewLayout.fixed(width: CGFloat(widthSize + 40), height: CGFloat(heightSize + 10)))
        .padding(5)
        .edgesIgnoringSafeArea(.all)
    }

}
