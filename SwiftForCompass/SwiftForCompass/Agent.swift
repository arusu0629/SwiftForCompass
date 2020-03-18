//
//  Agent.swift
//  SwiftForCompass
//
//  Created by Toru Nakandakari on 2020/03/16.
//  Copyright © 2020 仲村渠亨. All rights reserved.
//

import Foundation
import Combine

struct Agent {
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    enum CompassApiError: Error {
        case network
        case cannotCastHttpResponse
        case cannotDecode
        case unknown
    }
    
    func run<T: Decodable>(_ request: URLRequest, onDecode: @escaping (Result<Response<T>, CompassApiError>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            func execCompletionOnMainThread(_ result: Result<Response<T>, CompassApiError>) {
                DispatchQueue.main.async {
                    onDecode(result)
                }
            }
            
            if error != nil {
                execCompletionOnMainThread(.failure(.network))
                return
            }
            
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                execCompletionOnMainThread(.failure(.cannotCastHttpResponse))
                return
            }
            
            switch httpResponse.statusCode {
            case 200, 201, 204:
                do {
                    let jsonDecoder = JSONDecoder()
                    let value = try jsonDecoder.decode(T.self, from: data ?? Data())
                    let response = Response(value: value, response: httpResponse)
                    execCompletionOnMainThread(.success(response))
                } catch {
                    execCompletionOnMainThread(.failure(.cannotDecode))
                }
            default:
                execCompletionOnMainThread(.failure(.unknown))
            }
        }
        
        task.resume()
    }
}

enum CompassApi {
    static let agent = Agent()
    static let base = URL(string: "https://connpass.com/api/v1")!
}

extension CompassApi {
    static func searchEvent(_ withKeyword: String, startIndex: Int = 1, count: Int = 10, completion: @escaping ((Result<Agent.Response<SearchEventsResponse>, Agent.CompassApiError>) -> Void)) {
        let path = "event"
        let url = base.appendingPathComponent(path)
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = [
            URLQueryItem(name: "start", value: "\(startIndex)"),
            URLQueryItem(name: "count", value: "\(count)")
        ]
        if withKeyword != "" {
            urlComponents.queryItems = [
                URLQueryItem(name: "keyword", value: withKeyword)
            ]
        }
        let request = URLRequest(url: urlComponents.url!)
        agent.run(request, onDecode: completion)
    }
}
