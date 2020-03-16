//
//  Event.swift
//  SwiftForCompass
//
//  Created by Toru Nakandakari on 2020/03/16.
//  Copyright © 2020 仲村渠亨. All rights reserved.
//

import Foundation

struct SearchEventsResponse: Codable {
    let resultReturned: Int // 含まれる検索結果の件数
    let resultAvailable: Int // 検索結果の総件数
    let events: [Event] // イベントリスト
}

extension SearchEventsResponse {
    enum CodingKeys: String, CodingKey {
        case resultReturned = "results_returned"
        case resultAvailable = "results_available"
        case events = "events"
    }
}

struct Event: Codable {
    let id: Int
    let title: String
    let description: String
    let url: String?
    let startAt: String?
    let endAt: String?
    let address: String?
    let place: String?
    let lat: String?
    let lon: String?
    let limit: Int?
    let accepted: Int?
    let waiting: Int?
}

extension Event {
    enum CodingKeys: String, CodingKey {
        case id = "event_id"
        case title = "title"
        case description = "description"
        case url = "event_url"
        case startAt = "started_at"
        case endAt = "ended_at"
        case address = "address"
        case place = "place"
        case lat = "lat"
        case lon = "lon"
        case limit = "limit"
        case accepted = "accepted"
        case waiting = "waiting"
    }
}
