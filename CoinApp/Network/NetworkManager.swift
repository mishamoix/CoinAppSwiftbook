//
//  NetworkManager.swift
//  CoinApp
//
//  Created by mike on 23.06.2024.
//

import Foundation

protocol NetworkManager {
    func fetch<T: Decodable>(builder: RequestBuilder) async throws -> T
}

final class NetworkManagerImpl {
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return URLSession(configuration: config)
    }()

    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase //"key_snake" -> keySnake
        return decoder
    }()
}

extension NetworkManagerImpl: NetworkManager {
    func fetch<T>(builder: RequestBuilder) async throws -> T where T : Decodable {
        let request = builder.buildRequest()

        let (data, response) = try await session.data(for: request)

        if let response = response as? HTTPURLResponse, [401, 403].contains(response.statusCode) {
            throw AppError.unauth
        }

        let model = try decoder.decode(T.self, from: data)
        return model
    }
}
