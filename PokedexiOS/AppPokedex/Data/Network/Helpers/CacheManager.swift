//
//  CacheManager.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 19/08/23.
//

import UIKit

final class CacheManager {

    // MARK: - Singleton instance
    public static let shared = CacheManager()

    // MARK: - Cache data
    private var pokemonInformationCache: NSCache<NSString, PokemonDataWrapper> = NSCache()
    private var pokemonTypeCache: NSCache<NSString, PokemonTypeWrapper> = NSCache()
    private var pokemonDescriptionDataCache: NSCache<NSString, PokemonDescriptionDataWrapper> = NSCache()
    private var pokemonImageCache: NSCache<NSString, UIImage> = NSCache()

    private init() {
        setupCacheLimits()
    }

    private func setupCacheLimits() {
        pokemonInformationCache.totalCostLimit = 1024 * 1024 * 100 // 100 MB
        pokemonTypeCache.totalCostLimit = 1024 * 1024 * 100 // 100 MB
        pokemonDescriptionDataCache.totalCostLimit = 1024 * 1024 * 100 // 100 MB
        pokemonImageCache.totalCostLimit = 1024 * 1024 * 500 // 500 MB
    }

    // MARK: - Cache setters
    public func cachePokemonInformation(_ data: PokemonDataWrapper, forKey key: String) {
        pokemonInformationCache.setObject(data, forKey: key as NSString)
    }

    public func cachePokemonType(_ type: PokemonTypeWrapper, forKey key: String) {
        pokemonTypeCache.setObject(type, forKey: key as NSString)
    }

    public func cachePokemonDescriptionData(_ descriptionData: PokemonDescriptionDataWrapper, forKey key: String) {
        pokemonDescriptionDataCache.setObject(descriptionData, forKey: key as NSString)
    }

    public func cachePokemonImage(_ image: UIImage, forKey key: String) {
        pokemonImageCache.setObject(image, forKey: key as NSString)
    }

    // MARK: - Cache getters
    public func getPokemonInformation(forKey key: String) -> PokemonDataWrapper? {
        return pokemonInformationCache.object(forKey: key as NSString)
    }

    public func getPokemonType(forKey key: String) -> PokemonTypeWrapper? {
        return pokemonTypeCache.object(forKey: key as NSString)
    }

    public func getPokemonDescriptionData(forKey key: String) -> PokemonDescriptionDataWrapper? {
        return pokemonDescriptionDataCache.object(forKey: key as NSString)
    }

    public func getPokemonImage(forKey key: String) -> UIImage? {
        return pokemonImageCache.object(forKey: key as NSString)
    }

}
