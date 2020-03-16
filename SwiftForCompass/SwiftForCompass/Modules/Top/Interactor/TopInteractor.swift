//
//  TopTopInteractor.swift
//  SwiftForCompass
//
//  Created by Toru_Nakandakari on 16/03/2020.
//  Copyright © 2020 t-nakandakari. All rights reserved.
//

class TopInteractor: TopInteractorInput {

    weak var output: TopInteractorOutput!
    
    func fetchEvent(_ searchWords: String?) {
        print("[TopInteractor] fetchEvent")
        CompassApi.searchEvent(searchWords) { (result) in
            switch result {
            case .success(let response):
                self.output.onSuccessedFetchEvent(events: response.value.events)
            case .failure(let error):
                print(error)
                self.output.onFailedFetchEvent(errorMessage: error.localizedDescription)
            }
        }
    }
    
}
