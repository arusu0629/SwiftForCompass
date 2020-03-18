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
    private var noMoreEvent: Bool {
        return self.eventList.count >= lastSearchedWordEventAvailableCount
    }
    // イベント情報の最大件数
    private var lastSearchedWordEventAvailableCount = 10
    // イベントの取得件数
    let eventFetchCount = 10
    // 実際に取得するイベントの件数
    private var actualEventFetchCount: Int {
        var count = eventFetchCount
        if (self.eventList.count + eventFetchCount) > lastSearchedWordEventAvailableCount {
            count = lastSearchedWordEventAvailableCount - self.eventList.count
        }
        return count
    }
    
    // 最後に検索した文字列
    private var lastSearchKeyword = ""

    // MARK: TopViewOutput
    func viewIsReady() {
    }
    // 最新イベント情報を取得(主にPull To Refreshで利用)
    func refreshEventList(keyword: String = "") {
        if isRefresing {
            return
        }
        onSearchEvent(keyword: keyword)
        self.interactor.refreshEvent(keyword)
        isRefresing = true
    }

    // 次のイベント情報を取得(主にTableViewの最下部時のフェッチで利用)
    func fetchEventList(keyword: String = "") {
        if isFetching {
            return
        }
        onSearchEvent(keyword: keyword)
        if noMoreEvent {
            return
        }
        self.interactor.fetchEvent(keyword, startIndex: self.eventList.count + 1, count: actualEventFetchCount)
        isFetching = true
    }
    
    // イベント情報取得前に行う処理
    private func onSearchEvent(keyword: String) {
        // 同じ検索キーワードの場合は特に何もしない
        if lastSearchKeyword == keyword {
            return
        }
        // 異なる検索キーワードの場合はこれまで表示していたイベント情報をリセットする
        eventList = []
        lastSearchKeyword = keyword
        lastSearchedWordEventAvailableCount = 10
    }
    
    // MARK: TopInteractorOutput
    func onSuccessedFetchEvent(events: [Event], availableEventCount: Int) {
        self.eventList.append(contentsOf: events)
        self.view.reloadDataWithEvents(events: self.eventList)

        self.lastSearchedWordEventAvailableCount = availableEventCount
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
        isRefresing = false
    }
    
    func onFailedRefreshEvent(errorMessage: String) {
        print("[onFailedRefreshEvent] error = \(errorMessage)")
        isRefresing = false
    }
}
