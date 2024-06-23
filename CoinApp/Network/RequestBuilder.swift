//
//  RequestBuilder.swift
//  CoinApp
//
//  Created by mike on 23.06.2024.
//

import Foundation

enum NetworkMethod: String {
    case get = "GET"
    case post = "POST"
}

final class RequestBuilder {

    private let host: String
    private var method: NetworkMethod = .get
    private var path: [String] = []
    private var query: [String: String]?
    private var body: Data?
    private var headers: [String: String]?

    private var needAuth: Bool = false

    init(host: String = NetworkConstants.host) {
        self.host = host
    }

    func method(_ method: NetworkMethod) -> Self {
        self.method = method
        return self
    }

    func setNeedAuth() -> Self {
        needAuth = true
        return self
    }

    func path(_ path: String...) -> Self {
        self.path.append(contentsOf: path)
        return self
    }

    func body(_ body: Data) -> Self {
        self.body = body
        return self
    }

    func headers(_ headers: [String: String]) -> Self {
        self.headers = headers
        return self
    }

    func query(_ query: [String: String]) -> Self {
        self.query = query
        return self
    }

    func buildRequest() -> URLRequest {
        let url = buildURL()

        var r = URLRequest(url: url)
        r.httpMethod = method.rawValue

        headers?.forEach({ (key: String, value: String) in
            r.allHTTPHeaderFields?[key] = value
        })

        if needAuth {
            r.allHTTPHeaderFields?["x-cg-demo-api-key"] = API_KEY
        }

        // add body

        return r
    }
}

private extension RequestBuilder {
    func buildURL() -> URL {
        let fullPath = path.joined(separator: "/")

        // Construct the URL components
        var urlComponents = URLComponents(string: host)
        urlComponents?.path = "/\(fullPath)"

        // Add query items if any
        if let query = query {
            urlComponents?.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        // Construct the final URL
        return urlComponents!.url!
    }
}
