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
    let eventFetchCount = 50
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
        // TOOD: 最後に検索したイベント名を端末に保存しておき、それを検索するようにする
        fetchEventList(keyword: "")
    }
    
    func eventSearchTextFieldReturn(searchWord: String) {
        fetchEventList(keyword: searchWord)
    }
    
    func eventListTableViewPullToRefresh() {
        fetchLatestEvent(keyword: lastSearchKeyword)
    }
    
    func eventListTablelViewDidBottom() {
        fetchEventList(keyword: lastSearchKeyword)
    }
    // 最新イベント情報を取得(主にPull To Refreshで利用)
    private func fetchLatestEvent(keyword: String) {
        if isRefresing {
            return
        }
        self.interactor.fetchLatestEvent(keyword)
        isRefresing = true
    }

    // 次のイベント情報を取得(主にTableViewの最下部時のフェッチで利用)
    private func fetchEventList(keyword: String) {
        if isFetching {
            return
        }
        onSearchEvent(keyword: keyword)
        if noMoreEvent {
            return
        }
        self.interactor.fetchEvent(keyword, startIndex: 100, count: actualEventFetchCount)
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
    
    func onSuccessedFetchLatestEvent(events: [Event], availableEventCount: Int) {
        self.eventList = createEventList(latestEvents: events)
        self.view.reloadDataWithEvents(events: self.eventList)
        
        self.lastSearchedWordEventAvailableCount = availableEventCount
        isRefresing = false
    }
    
    private func createEventList(latestEvents: [Event]) -> [Event] {
        // 最新イベント情報を既イベント情報リストに加える
        var eventList = self.eventList
        // 先頭に含まれるイベント情報が最新なので逆順から配列に追加していく
        for index in (0..<latestEvents.count).reversed() {
            // すでに含まれている場合は追加しない
            if eventList.contains(where: { (event) in
                event.id == latestEvents[index].id
            }) {
                continue
            }
            eventList.insert(latestEvents[index], at: 0)
        }
        
        return eventList
    }
    
    func onFailedFetchLatestEvent(errorMessage: String) {
        print("[onFailedFetchLatestEvent] error = \(errorMessage)")
        isRefresing = false
    }
}
