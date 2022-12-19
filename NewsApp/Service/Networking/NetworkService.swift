//
//  NetworkService.swift
//  NewsApp
//
//  Created by Dmytro Lupych on 2/9/22.
//  Copyright © 2022 Dmitry Lupich. All rights reserved.
//

import Combine
import Foundation

public protocol NetworkProtocol {
    func request<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, NAError>
}

public final class Networking {
    private let session: URLSession
    private let decoder = JSONDecoder()

    public init(session: URLSession) {
        self.session = session
    }
}

extension Networking: NetworkProtocol {
    public func request<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, NAError> {

        guard let url = endpoint.url else {
            return Fail(error: NAError.badUrl).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod

        return session.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .mapError { e -> NAError in
                switch e {
                case is Swift.DecodingError:
                    return .mapping
                default:
                    return .generic
                }
            }
            .eraseToAnyPublisher()
    }
}
