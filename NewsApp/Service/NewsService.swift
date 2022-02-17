//
//  NewsService.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/8/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import Combine
import Foundation

// MARK: - Service Contract

public protocol NewsServiceContract {
    func latestNews(endpoint: Endpoint) -> AnyPublisher<[NewsModel], NAError>
}

// MARK: - News Service

public final class NewsService {
    internal let jsonDecoder = JSONDecoder()
    private let network: NetworkContract
    public init(network: NetworkContract) {
        self.network = network
    }
}

// MARK: - Protocol Methods

extension NewsService: NewsServiceContract {
    public func latestNews<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<[T], NAError> {
        network.request(endpoint: endpoint)
    }
}
