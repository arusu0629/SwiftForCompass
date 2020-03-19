//
//  TopTopInteractor.swift
//  SwiftForCompass
//
//  Created by Toru_Nakandakari on 16/03/2020.
//  Copyright © 2020 t-nakandakari. All rights reserved.
//

class TopInteractor: TopInteractorInput {

    weak var output: TopInteractorOutput!
    
    func fetchEvent(_ searchWords: String, startIndex: Int, count: Int) {
        CompassApi.searchEvent(searchWords, startIndex: startIndex, count: count) { (result) in
            switch result {
            case .success(let response):
                self.output.onSuccessedFetchEvent(events: response.value.events, availableEventCount: response.value.resultAvailable)
            case .failure(let error):
                print(error)
                self.output.onFailedFetchEvent(errorMessage: error.localizedDescription)
            }
        }
    }
    
    func fetchLatestEvent(_ searchWords: String) {
        CompassApi.searchEvent(searchWords) { (result) in
            switch result {
            case .success(let response):
                self.output.onSuccessedFetchLatestEvent(events: response.value.events, availableEventCount: response.value.resultAvailable)
            case .failure(let error):
                print(error)
                self.output.onFailedFetchLatestEvent(errorMessage: error.localizedDescription)
            }
        }
    }
    
    func refreshEvent(_ searchWords: String) {
        CompassApi.searchEvent(searchWords) { (result) in
            switch result {
            case .success(let response):
                self.output.onSuccessedRefreshEvent(events: response.value.events, availableEventCount: response.value.resultAvailable)
            case .failure(let error):
                print(error)
                self.output.onFailedRefreshEvent(errorMessage: error.localizedDescription)
            }
        }

    }
    
}
