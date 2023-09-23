//
//  String+Extensions.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 19/07/23.
//

import Foundation

extension String {

    var localized: String {
        NSLocalizedString(self, comment: "")
    }

    func clearText() -> String {
        var parrafosUnicos: [String] = []
        let parrafos = description.components(separatedBy: ".")

        parrafos.forEach { parrafo in
            if !parrafosUnicos.contains(parrafo) {
                parrafosUnicos.append(parrafo)
            }
        }

        let textoLimpio = parrafosUnicos
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression, range: nil) }
            .joined(separator: ". \n\n")

        return textoLimpio
    }

}
