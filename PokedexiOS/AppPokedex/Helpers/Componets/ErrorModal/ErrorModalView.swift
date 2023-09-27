//
//  ErrorModalView.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 24/08/23.
//

import UIKit
import SwiftUI
import Lottie

class ErrorModalView: UIView {

    // MARK: - UIComponents
    private var backgroundView: UIView = {
        var view = UIView()
        view.backgroundColor = .defaultPokemonColor?.withAlphaComponent(0.6)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var modalForm: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var modalContentView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var logoPokeballImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .pokeballLogo?.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .defaultPokemonColor
        imageView.alpha = 0.5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.startRotationAnimation(animationDuration: 2)
        return imageView
    }()

    private var closeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .closeImage
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.tintColor = .defaultPokemonColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var stackContentView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.backgroundColor = .white
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private var animationView: LottieAnimationView = {
        var animationView = LottieAnimationView()
        animationView = .init(name: "errorAnimation")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.backgroundColor = .white
        animationView.animationSpeed = 1
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.play()
        return animationView
    }()

    public var messageLabel: UILabel = {
        var label = UILabel()
        label.text = LocalizedKeys.GeneralTexts.dummyStringContent
        label.numberOfLines = 0
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .justified
        return label
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
        clipsToBounds = true
    }

    private func addViews() {
        [backgroundView, modalForm].forEach(addSubview)
        [modalContentView].forEach(modalForm.addSubview)
        [stackContentView, closeImage, logoPokeballImage].forEach(modalContentView.addSubview)
        [animationView, messageLabel].forEach(stackContentView.addArrangedSubview)
    }

    private func setupContrains() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),

            modalForm.centerYAnchor.constraint(equalTo: centerYAnchor),
            modalForm.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            modalForm.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            modalContentView.topAnchor.constraint(equalTo: modalForm.topAnchor),
            modalContentView.leadingAnchor.constraint(equalTo: modalForm.leadingAnchor),
            modalContentView.trailingAnchor.constraint(equalTo: modalForm.trailingAnchor),
            modalContentView.bottomAnchor.constraint(equalTo: modalForm.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            logoPokeballImage.topAnchor.constraint(equalTo: modalContentView.topAnchor),
            logoPokeballImage.trailingAnchor.constraint(equalTo: modalContentView.trailingAnchor),
            logoPokeballImage.heightAnchor.constraint(equalToConstant: 60),
            logoPokeballImage.widthAnchor.constraint(equalTo: logoPokeballImage.heightAnchor, multiplier: 1),

            closeImage.centerXAnchor.constraint(equalTo: logoPokeballImage.centerXAnchor),
            closeImage.centerYAnchor.constraint(equalTo: logoPokeballImage.centerYAnchor),

            stackContentView.topAnchor.constraint(equalTo: modalContentView.topAnchor, constant: 20),
            stackContentView.leadingAnchor.constraint(equalTo: modalContentView.leadingAnchor, constant: 20),
            stackContentView.trailingAnchor.constraint(equalTo: modalContentView.trailingAnchor, constant: -20),
            stackContentView.bottomAnchor.constraint(equalTo: modalContentView.bottomAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: modalContentView.widthAnchor, multiplier: 0.4),
            animationView.heightAnchor.constraint(equalTo: animationView.widthAnchor, multiplier: 1)
        ])
    }

    public func setCloseAction(with viewController: UIViewController, action: Selector) {
        closeImage.isUserInteractionEnabled = true
        closeImage.addGestureRecognizer(UITapGestureRecognizer(target: viewController, action: action))

        backgroundView.isUserInteractionEnabled = true
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: viewController, action: action))
    }

}

struct ErrorModalView_Previews: PreviewProvider {
   static var previews: some View {
       ViewControllerPreview {
           ErrorModalViewController.create()
       }
   }
}
