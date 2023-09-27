//
//  UIView+Extensions.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 12/07/23.
//

import UIKit

extension UIView {

    func startRotationAnimation(animationDuration duration: Double) {
        UIView.animate(withDuration: duration/2, delay: 0, options: .curveLinear, animations: { [weak self] in
            self?.transform = CGAffineTransform(rotationAngle: .pi)
        }, completion: { [weak self] _ in
            UIView.animate(withDuration: duration/2, delay: 0, options: .curveLinear, animations: { [weak self] in
                self?.transform = CGAffineTransform(rotationAngle: .pi*2)
            }, completion: { [weak self] _ in
                self?.startRotationAnimation(animationDuration: duration)
            })
        })
    }

    static func getTagView(type: String) -> UIView {
        let label = UILabel()
        label.textColor = .white
        label.text = type.capitalized
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .center
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false

        let containerView = UIView()
        containerView.backgroundColor = .whiteTrasnparent
        containerView.layer.cornerRadius = 10
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(label)

        let padding = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding.top),
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding.left),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding.bottom),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding.right)
        ])

        return containerView
    }
}
