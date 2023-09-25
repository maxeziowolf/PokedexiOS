//
//  UIColor+Extensions.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 12/07/23.
//

import UIKit

// MARK: - UIColors extension
extension UIColor {

    // MARK: - Colors
    static var whiteTrasnparent: UIColor {
        return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.4)
    }

    // MARK: - Functions
    static func textColor(for backgroundColor: UIColor?) -> UIColor {
        guard let backgroundColorComponents = backgroundColor?.cgColor.components else {
            return .black
        }

        let red = backgroundColorComponents[0]
        let green = backgroundColorComponents[1]
        let blue = backgroundColorComponents[2]

        let luminance = (0.299 * red + 0.587 * green + 0.114 * blue)

        if luminance > 0.7 {
            return .black
        } else {
            return .white
        }
    }

    static func getPokemonTypeColor(pokemonType typeName: String) -> UIColor? {
        return PokemonTypes.getPokemonTypeColor(pokemonType: typeName.capitalized)
    }

}
