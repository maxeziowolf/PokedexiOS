//
//  Global Content.swift
//  PokedexiOS
//
//  Created by Maximiliano Ovando Ramírez on 25/09/23.
//

import Foundation

struct GlobalContent {

    // MARK: - Varviables
    public static var shared = GlobalContent()
    public var totalCountPokemons: Int = 0
    public var lenguageCode: String = Locale.current.language.languageCode?.identifier ?? "es"

    // MARK: - Singleton
    private init() {}
}
