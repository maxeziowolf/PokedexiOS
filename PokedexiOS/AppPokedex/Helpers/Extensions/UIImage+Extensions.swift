//
//  UIImage+Extensions.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 12/07/23.
//

import UIKit

// MARK: - UIImage extension
extension UIImage {

    // MARK: - Images
    static var pokeballLogo: UIImage? {
        return UIImage(named: "pokeball.logo.image")
    }

    static var pokemonDummy: UIImage? {
        return UIImage(named: "dummy.pokemon.image")
    }

    static var pokemonDummy2: UIImage? {
        return UIImage(named: "dummy2.pokemon.image")
    }

    static var closeImage: UIImage? {
        return UIImage(systemName: "x.circle")
    }

    func compressImage() -> UIImage? {
        if let originalImageData = self.pngData() {
            if let originalUIImage = UIImage(data: originalImageData) {
                let newSize = CGSize(width: originalUIImage.size.width * 0.3, height: originalUIImage.size.height * 0.3)
                UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
                originalUIImage.draw(in: CGRect(origin: .zero, size: newSize))
                let reducedImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()

                if let reducedImageData = reducedImage?.pngData() {
                    return UIImage(data: reducedImageData)
                }
            }
        }
        return nil
    }

}
