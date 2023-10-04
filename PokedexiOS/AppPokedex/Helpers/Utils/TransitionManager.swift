//
//  TransitionManager.swift
//  PokedexiOS
//
//  Created by Maximiliano Ovando Ramírez on 28/09/23.
//

import UIKit

final class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning {

    // MARK: - Variables
    private let duration: TimeInterval
    private var operation = UINavigationController.Operation.push
    public var navigationBar: UINavigationBar?

    // MARK: - Init
    init(duration: TimeInterval) {
        self.duration = duration
    }

    // MARK: - Functions
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to)
        else {
            transitionContext.completeTransition(false)
            return
        }

        animateTransition(from: fromViewController, to: toViewController, with: transitionContext)
    }
}

// MARK: - UINavigationControllerDelegate
extension TransitionManager: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        self.operation = operation

            return self
    }
}

// MARK: - Animations
private extension TransitionManager {
    func animateTransition(from fromViewController: UIViewController, to toViewController: UIViewController, with context: UIViewControllerContextTransitioning) {
        switch operation {
        case .push:
            guard
                let albumsViewController = fromViewController as? PokemonListViewController,
                let detailsViewController = toViewController as? PokemonDetailViewController
            else { return }

            presentViewController(detailsViewController, from: albumsViewController, with: context)

        case .pop:
            guard
                let detailsViewController = fromViewController as? PokemonDetailViewController,
                let albumsViewController = toViewController as? PokemonListViewController
            else { return }

            dismissViewController(detailsViewController, to: albumsViewController, with: context)

        default:
            break
        }
    }

    func presentViewController(_ toViewController: PokemonDetailViewController, from fromViewController: PokemonListViewController, with context: UIViewControllerContextTransitioning) {

        guard
            let pokemonCell = fromViewController.pokemonListView.currentCell,
            let pokemonCellImage = fromViewController.pokemonListView.currentCell?.pokemonImage,
            let pokeballCellImage = fromViewController.pokemonListView.currentCell?.logoPokeballImage
        else { return}

        let pokemonDetailView = toViewController.pokemonDetailView

        navigationBar?.isHidden = true
        navigationBar?.prefersLargeTitles = false

        toViewController.view.layoutIfNeeded()

        let containerView = context.containerView

        let snapshotContentView = UIView()
        snapshotContentView.backgroundColor = pokemonCell.pokemonColor
        snapshotContentView.frame = containerView.convert(pokemonCell.contentView.frame, from: pokemonCell)
        snapshotContentView.layer.cornerRadius = pokemonCell.contentView.layer.cornerRadius

        let snapshotpokemonImageView = UIImageView()
        snapshotpokemonImageView.contentMode = pokemonCellImage.contentMode
        snapshotpokemonImageView.image = pokemonCellImage.image
        snapshotpokemonImageView.frame = containerView.convert(pokemonCellImage.frame, from: pokemonCell.pokemonImageContent)

        let snapshotPokeball = UIImageView()
        snapshotPokeball.contentMode = pokeballCellImage.contentMode
        snapshotPokeball.image = pokeballCellImage .image
        snapshotPokeball.tintColor = pokeballCellImage.tintColor.withAlphaComponent(0.4)
        snapshotPokeball.frame = containerView.convert(pokeballCellImage.frame, from: pokemonCell.pokemonImageContent)

        containerView.addSubview(toViewController.view)
        containerView.addSubview(snapshotContentView)
        containerView.addSubview(snapshotPokeball)
        containerView.addSubview(snapshotpokemonImageView)

        toViewController.view.isHidden = true

        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            snapshotContentView.frame = containerView.convert(toViewController.view.frame, from: toViewController.view)
            var frame = pokemonDetailView.convert(pokemonDetailView.pokemonImage.frame, from: pokemonDetailView)
            frame.origin.y += 64
            snapshotpokemonImageView.frame = frame
            var frame2 = pokemonDetailView.convert(pokemonDetailView.logoPokeballImage.frame, from: pokemonDetailView)
            frame2.origin.y += 64
            snapshotPokeball.frame = frame2
            snapshotpokemonImageView.layer.cornerRadius = 0
        }

        animator.addCompletion { position in
            toViewController.view.isHidden = false
            snapshotpokemonImageView.removeFromSuperview()
            snapshotContentView.removeFromSuperview()
            snapshotPokeball.removeFromSuperview()
            context.completeTransition(position == .end)
        }

        animator.startAnimation()
    }

    func dismissViewController(_ fromViewController: PokemonDetailViewController, to toViewController: PokemonListViewController, with context: UIViewControllerContextTransitioning) {
        guard
            let pokemonCell = toViewController.pokemonListView.currentCell,
            let pokemonImageCell = toViewController.pokemonListView.currentCell?.pokemonImage,
            let pokeballImageCell = toViewController.pokemonListView.currentCell?.logoPokeballImage

        else { return}

        let pokemonDetailView = fromViewController.pokemonDetailView

        navigationBar?.isHidden = false
        toViewController.view.layoutIfNeeded()

        let containerView = context.containerView

        let snapshotContentView = UIView()
        snapshotContentView.backgroundColor = pokemonCell.pokemonColor
        snapshotContentView.frame = containerView.convert(pokemonDetailView.frame, from: pokemonDetailView)
        snapshotContentView.layer.cornerRadius = pokemonDetailView.layer.cornerRadius

        let snapshotPokemonImageView = UIImageView()
        snapshotPokemonImageView.contentMode = pokemonImageCell.contentMode
        snapshotPokemonImageView.image = pokemonImageCell.image
        snapshotPokemonImageView.frame = pokemonDetailView.convert(pokemonDetailView.pokemonImage.frame, from: pokemonDetailView)

        let snapshotPokeballImageView = UIImageView()
        snapshotPokeballImageView.contentMode = pokeballImageCell.contentMode
        snapshotPokeballImageView.image = pokeballImageCell .image
        snapshotPokeballImageView.tintColor = pokeballImageCell.tintColor.withAlphaComponent(0.4)
        snapshotPokeballImageView.frame = pokemonDetailView.convert(pokemonDetailView.logoPokeballImage.frame, from: pokemonDetailView)

        containerView.addSubview(toViewController.view)
        containerView.addSubview(snapshotContentView)
        containerView.addSubview(snapshotPokeballImageView)
        containerView.addSubview(snapshotPokemonImageView)

        fromViewController.view.isHidden = true

        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            snapshotContentView.frame = containerView.convert(pokemonCell.contentView.frame, from: pokemonCell)
            snapshotPokemonImageView.frame = containerView.convert(pokemonImageCell.frame, from: pokemonCell.pokemonImageContent)
            snapshotPokeballImageView.frame = containerView.convert(pokeballImageCell.frame, from: pokemonCell.pokemonImageContent)
            snapshotContentView.layer.cornerRadius = pokemonCell.contentView.layer.cornerRadius
        }

        animator.addCompletion { position in
            fromViewController.view.isHidden = false
            snapshotPokemonImageView.removeFromSuperview()
            snapshotContentView.removeFromSuperview()
            snapshotPokeballImageView.removeFromSuperview()
            context.completeTransition(position == .end)
        }

        animator.startAnimation()
    }
}
