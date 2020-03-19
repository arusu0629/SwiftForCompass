//
//  TopTopPresenter.swift
//  SwiftForCompass
//
//  Created by Toru_Nakandakari on 16/03/2020.
//  Copyright © 2020 t-nakandakari. All rights reserved.
//

class TopPresenter: TopModuleInput {

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
    private var lastSearchedWordEventAvailableCount = 100
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
    
    private func fetchEventList(keyword: String) {
        if isFetching {
            return
        }
        self.interactor.fetchEvent(keyword, startIndex: self.eventList.count + 1, count: actualEventFetchCount)
        self.view.showLoading()
        isFetching = true
    }
    
    // 最新イベント情報を取得(主にPull To Refreshで利用)
    private func fetchLatestEvent(keyword: String) {
        if isFetching {
            return
        }
        self.interactor.fetchLatestEvent(keyword)
        isFetching = true
    }
 
    // ナビゲーションバーの更新ボタンを押した時
    private func refreshEvent(keyword: String) {
        if isRefresing {
            return
        }
        self.interactor.refreshEvent(keyword)
        self.view.showLoading()
        isRefresing = true
    }

    // イベントリストテーブルビューの最下部に到達した時に次のイベント情報をフェッチする
    private func fetchNextEventList() {
        if noMoreEvent {
            return
        }
        self.fetchEventList(keyword: lastSearchKeyword)
    }
    
    // テキストフィールドの文字からイベント検索をした場合
    private func searchEventList(keyword: String) {
        if isFetching {
            return
        }
        // 異なる検索キーワードの場合はこれまで表示していたイベント情報をリセットする
        if keyword != lastSearchKeyword {
            eventList = []
            lastSearchKeyword = keyword
        }
        fetchEventList(keyword: keyword)
    }

    private func createLatestEventList(latestEvents: [Event]) -> [Event] {
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
    
}

extension TopPresenter: TopViewOutput {
    func viewIsReady() {
        // TOOD: 最後に検索したイベント名を端末に保存しておき、それを検索するようにする
        fetchEventList(keyword: lastSearchKeyword)
    }
    
    func eventSearchTextFieldReturn(searchWord: String) {
        searchEventList(keyword: searchWord)
    }
    
    func eventListTableViewPullToRefresh() {
        fetchLatestEvent(keyword: lastSearchKeyword)
    }
    
    func eventListTablelViewDidBottom() {
        fetchEventList(keyword: lastSearchKeyword)
    }
    
    func onTappedRefreshButton() {
        refreshEvent(keyword: lastSearchKeyword)
    }
}

extension TopPresenter: TopInteractorOutput {
    func onSuccessedFetchEvent(events: [Event], availableEventCount: Int) {
        self.eventList.append(contentsOf: events)
        self.view.reloadDataWithEvents(events: self.eventList)

        self.lastSearchedWordEventAvailableCount = availableEventCount
        self.view.hideLoading()
        isFetching = false
    }

    func onSuccessedFetchLatestEvent(events: [Event], availableEventCount: Int) {
        self.eventList = createLatestEventList(latestEvents: events)
        self.view.reloadDataWithEvents(events: self.eventList)
        
        self.lastSearchedWordEventAvailableCount = availableEventCount
        isFetching = false
    }

    func onSuccessedRefreshEvent(events: [Event], availableEventCount: Int) {
        self.eventList = events
        self.view.reloadDataWithEvents(events: self.eventList)
        
        self.lastSearchedWordEventAvailableCount = availableEventCount
        self.view.hideLoading()
        isRefresing = false
    }

    func onFailedFetchEvent(errorMessage: String) {
        print("[onFailedFetchEvent] error = \(errorMessage)")
        self.view.hideLoading()
        isFetching = false
    }

    func onFailedFetchLatestEvent(errorMessage: String) {
        print("[onFailedFetchLatestEvent] error = \(errorMessage)")
        isFetching = false
    }

    func onFailedRefreshEvent(errorMessage: String) {
        print("onFailedRefreshEvent")
        self.view.hideLoading()
        isRefresing = false
    }
}
