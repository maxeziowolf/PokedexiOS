//
//  ErrorModalViewController.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 24/08/23.
//

import UIKit

class ErrorModalViewController: UIViewController {

    // MARK: - Variables
    var viewError = ErrorModalView()
    var doActionClose: (() -> Void)?

    // MARK: - Create functions
    final class func create(withAction action: (() -> Void)? = nil) -> ErrorModalViewController {
        let viewController = ErrorModalViewController(doActionClose: action)
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overCurrentContext
        return viewController
    }

    private init(viewError: ErrorModalView = ErrorModalView(), doActionClose: ( () -> Void)? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.viewError = viewError
        self.doActionClose = doActionClose
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = viewError
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewError.setCloseAction(with: self, action: #selector(closeModal))
    }

    // MARK: - Functions
    @objc
    func closeModal() {
        dismiss(animated: true) { [weak self] in
            self?.doActionClose?()
        }
    }
}
