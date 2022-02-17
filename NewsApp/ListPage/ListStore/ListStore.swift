//
//  ListStore.swift
//  NewsApp
//
//  Created by Dmytro Lupych on 2/8/22.
//  Copyright © 2022 Dmitry Lupich. All rights reserved.
//

import Common
import ComposableArchitecture
import Foundation

//MARK: - Action

public enum ListAction: Equatable {
    case start
    case scrollToBottomPage(Int)
    case loadedNews([NewsModel])
    case details(NewsModel)
}

//MARK: - State

public struct ListState: Equatable {
    public var news: [NewsModel]
    public var page: Int = 0
    
    public init(news: [NewsModel]) {
        self.news = news
    }
}

//MARK: - Reducer

public let listReducer = Reducer<ListState, ListAction, ListEnvironment>.init { state, action, environment in
    switch action {
    case .start:
        return environment
            .newsService
            .latestNews(endpoint: Endpoint.latestNews(page: 1))
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .map { ListAction.loadedNews($0) }
            .eraseToEffect()
    case .scrollToBottomPage(_):
        return .none
    case .loadedNews(let news):
        state.news += news
        return .none
    case .details(_):
        return .none
    }
}

//MARK: - Environment

public struct ListEnvironment {
    public let newsService: NewsServiceContract
    
    public init(newsService: NewsServiceContract) {
        self.newsService = newsService
    }
}
