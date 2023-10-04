//
//  PokemonAboutView.swift
//  PokedexiOS
//
//  Created by Maximiliano Ovando Ramírez on 03/10/23.
//

import UIKit

class PokemonAboutView: UIView {
    // MARK: - Outlets
    @IBOutlet weak var pokemonDescriptionLabel: UILabel!
    @IBOutlet weak var pokemonHeightLabel: UILabel!
    @IBOutlet weak var pokemonWeightLabel: UILabel!
    @IBOutlet weak var sizeTitleHeightLabel: UILabel!
    @IBOutlet weak var pokemonSizeCard: UIView!
    @IBOutlet weak var sizeTitleWightLabel: UILabel!

    // MARK: - Instance view
    class func instanceFromNib(description: String? = nil, height: String? = nil, weight: String? = nil ) -> UIView {

        guard let view = UINib(nibName: "PokemonAboutView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? PokemonAboutView else {
            return UIView()
        }

        view.setupUIConfiguration(view)
        view.setupInformation(description: description, height: height, weight: weight)

        return view
    }

    // MARK: - Setup UI Configuration
    private func setupUIConfiguration(_ view: PokemonAboutView) {
        view.sizeTitleHeightLabel.text = LocalizedKeys.GeneralTexts.heightTitleString
        view.sizeTitleWightLabel.text = LocalizedKeys.GeneralTexts.weightTitleString
        view.pokemonSizeCard.layer.cornerRadius = 8
        view.pokemonSizeCard.layer.shadowColor = UIColor.black.cgColor
        view.pokemonSizeCard.layer.shadowOpacity = 0.2
        view.pokemonSizeCard.layer.shadowOffset = .zero
        view.pokemonSizeCard.layer.shadowRadius = 5
        view.pokemonSizeCard.layer.masksToBounds = false
    }

    // MARK: - Setup Information
    public func setupInformation(description: String? = nil, height: String? = nil, weight: String? = nil ) {
        pokemonDescriptionLabel.text = description ?? "Sin informacion"
        pokemonHeightLabel.text = height ?? "Sin informacion"
        pokemonWeightLabel.text = weight ?? "Sin informacion"
    }

}
