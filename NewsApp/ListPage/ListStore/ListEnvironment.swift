//
//  ListEnvironment.swift
//  ListPage
//
//  Created by Dmitriy Lupych on 17.02.2023.
//  Copyright © 2023 Dmitry Lupich. All rights reserved.
//

import Common

//MARK: - List Environment

public struct ListEnvironment {
    public let newsService: NewsServiceProtocol

    public init(newsService: NewsServiceProtocol) {
        self.newsService = newsService
    }
}
