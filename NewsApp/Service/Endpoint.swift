//
//  Endpoint.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/8/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
}

public enum Endpoint {
    case latestNews(page: Int)

    private var path: String {
        switch self {
        case .latestNews(let page):
            return baseURL + "posts/?page=\(page)"
        }
    }
    
    public var url: URL? { URL(string: path) }

    private var baseURL: String {
        return AppConstants.Domain.baseURL
    }

    public var httpMethod: String {
        switch self {
        case .latestNews:
            return HTTPMethod.get.rawValue
        }
    }
}
