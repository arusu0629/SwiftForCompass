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
    
    private var eventList = [Event]()
    private var isFetching = false
    private var isRefresing = false
    
    // もう取得できるイベントが無い
    private var noMoreEvent = false
    // イベント情報の最大件数
    private var lastSearchedWordEventAvailableCount = 10
    // イベントの取得件数
    private var eventFetchCount = 10

    // MARK: TopViewOutput
    func viewIsReady() {
    }
    // 最新イベント情報を取得(主にPull To Refreshで利用)
    func refreshEventList(keyword: String?) {
        if isRefresing {
            return
        }
        self.interactor.refreshEvent(keyword)
        isRefresing = true
    }

    // 次のイベント情報を取得(主にTableViewの最下部時のフェッチで利用)
    func fetchEventList(keyword: String?) {
        if isFetching || noMoreEvent {
            return
        }
        var count = eventFetchCount
        if (self.eventList.count + eventFetchCount) > lastSearchedWordEventAvailableCount {
            count = lastSearchedWordEventAvailableCount - self.eventList.count
        }
        self.interactor.fetchEvent(keyword, startIndex: self.eventList.count + 1, count: count)
        isFetching = true
    }
    
    // MARK: TopInteractorOutput
    func onSuccessedFetchEvent(events: [Event], availableEventCount: Int) {
        self.eventList.append(contentsOf: events)
        self.view.reloadDataWithEvents(events: self.eventList)

        self.lastSearchedWordEventAvailableCount = availableEventCount
        if self.eventList.count >= self.lastSearchedWordEventAvailableCount {
            noMoreEvent = true
        }

        isFetching = false
    }
    
    func onFailedFetchEvent(errorMessage: String) {
        print("[onFailedFetchEvent] error = \(errorMessage)")
        isFetching = false
    }
    
    func onSuccessedRefreshEvent(events: [Event], availableEventCount: Int) {
        self.eventList = events
        self.view.reloadDataWithEvents(events: self.eventList)
        
        self.lastSearchedWordEventAvailableCount = availableEventCount
        if self.eventList.count >= self.lastSearchedWordEventAvailableCount {
            noMoreEvent = true
        }
        
        isRefresing = false
    }
    
    func onFailedRefreshEvent(errorMessage: String) {
        print("[onFailedRefreshEvent] error = \(errorMessage)")
        isRefresing = false
    }


}
