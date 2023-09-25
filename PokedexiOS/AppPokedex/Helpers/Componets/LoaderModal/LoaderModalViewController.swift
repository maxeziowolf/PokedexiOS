//
//  LoaderModalViewController.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 22/08/23.
//

import UIKit

class LoaderModalViewController: UIViewController {

    // MARK: - Variables
    var viewLoader = LoaderModalView()

    // MARK: - Create functions
    final class func create() -> LoaderModalViewController {
        let viewController = LoaderModalViewController()
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overCurrentContext
        return viewController
    }

    private init(viewLoader: LoaderModalView = LoaderModalView()) {
        self.viewLoader = viewLoader
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = viewLoader
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
