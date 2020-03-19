//
//  WebWebPresenter.swift
//  SwiftForCompass
//
//  Created by Toru_Nakandakari on 19/03/2020.
//  Copyright © 2020 t-nakandakari. All rights reserved.
//

class WebPresenter: WebModuleInput, WebViewOutput, WebInteractorOutput {

    weak var view: WebViewInput!
    var interactor: WebInteractorInput!
    var router: WebRouterInput!

    func viewIsReady() {

    }
}
