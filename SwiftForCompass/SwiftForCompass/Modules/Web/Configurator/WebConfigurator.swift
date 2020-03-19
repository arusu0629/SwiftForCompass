//
//  WebWebConfigurator.swift
//  SwiftForCompass
//
//  Created by Toru_Nakandakari on 19/03/2020.
//  Copyright © 2020 t-nakandakari. All rights reserved.
//

import UIKit

class WebModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? WebViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: WebViewController) {

        let router = WebRouter()

        let presenter = WebPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = WebInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
