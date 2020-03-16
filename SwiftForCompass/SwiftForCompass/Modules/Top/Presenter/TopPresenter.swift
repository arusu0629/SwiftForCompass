//
//  TopTopPresenter.swift
//  SwiftForCompass
//
//  Created by Toru_Nakandakari on 16/03/2020.
//  Copyright © 2020 t-nakandakari. All rights reserved.
//

class TopPresenter: TopModuleInput, TopViewOutput, TopInteractorOutput {

    weak var view: TopViewInput!
    var interactor: TopInteractorInput!
    var router: TopRouterInput!

    func viewIsReady() {

    }
}
