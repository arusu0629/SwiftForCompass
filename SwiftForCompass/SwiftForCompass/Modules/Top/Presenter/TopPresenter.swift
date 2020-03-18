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

    // MARK: TopViewOutput
    func viewIsReady() {
        print("[TopPresenter] viewIsReady")
        self.interactor.fetchEvent(nil)
    }
    func refreshEventList(keyword: String?) {
        print("[TopPresenter] refreshEventList")
        self.interactor.fetchEvent(keyword)
    }
    
    // MARK: TopInteractorOutput
    func onSuccessedFetchEvent(events: [Event]) {
        self.view.reloadDataWithEvents(events: events)
    }
    
    func onFailedFetchEvent(errorMessage: String) {
        print("[onFailedFetchEvent] error = \(errorMessage)")
    }

}
