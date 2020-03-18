//
//  TopTopConfigurator.swift
//  SwiftForCompass
//
//  Created by Toru_Nakandakari on 16/03/2020.
//  Copyright © 2020 t-nakandakari. All rights reserved.
//

import UIKit

class TopModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? TopViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: TopViewController) {

        let router = TopRouter()

        let presenter = TopPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = TopInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter

    }

}
