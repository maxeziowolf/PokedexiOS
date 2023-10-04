//
//  LoaderModalView.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 22/08/23.
//
import Foundation
import SwiftUI
import Lottie

// MARK: - Animation files options
enum LoaderAnimationFile: String, CaseIterable {
    case escuarolLoader = "escuarolAnimation"
    case diggletL5oader = "loaderAnimation"
}

final class LoaderModalView: UIView {

    // MARK: - UIComponents
    private var animationView: LottieAnimationView = {
        var animationView = LottieAnimationView()
        let animationFile = LoaderAnimationFile.allCases.randomElement()?.rawValue
        animationView = .init(name: animationFile ?? "loader")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.play()
        return animationView
    }()

    // MARK: - Inicializadores
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration functions
    private func setupUI() {
        viewConfiguration()
        addViews()
        setupContrains()
    }

    private func viewConfiguration() {
        backgroundColor = .defaultPokemonColor?.withAlphaComponent(0.6)
        clipsToBounds = true
    }

    private func addViews() {
        addSubview(animationView)
    }

    private func setupContrains() {
        NSLayoutConstraint.activate([
            animationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            animationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            animationView.heightAnchor.constraint(equalTo: animationView.widthAnchor, multiplier: 1),
            animationView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 6/8)
        ])
    }

}

struct LoaderModalView_Previews: PreviewProvider {
   static var previews: some View {
       ViewControllerPreview {
           LoaderModalViewController.create()
       }
   }
}
