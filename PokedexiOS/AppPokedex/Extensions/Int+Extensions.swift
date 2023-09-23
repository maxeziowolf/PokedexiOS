//
//  String+Extensions.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 12/07/23.
//

import Foundation

extension Int {

    func getNumberWithFormtat() -> String {
       return String(format: "#%03d", self)
    }

}
