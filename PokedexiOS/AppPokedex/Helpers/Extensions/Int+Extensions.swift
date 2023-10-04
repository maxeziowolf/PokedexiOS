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

    func formatMetersToString() -> String {
        let metters = Double(self) / 10
        let feet = metters / 0.3048 // 1 metro = 3.28084 pies
        let inches = (feet.truncatingRemainder(dividingBy: 1)) * 12

        return "\(Int(feet))' \(Int(inches))\" (\(String(format: "%.1f", metters))m)"
    }

    func formatKilogramsToString() -> String {
        let kilograms = Double(self) / 10
        let pounds = kilograms * 2.20462 // 1 kilogramo = 2.20462 libras
        return "\(String(format: "%.1f", pounds)) lbs (\(String(format: "%.1f", kilograms)) kg)"
    }

}
