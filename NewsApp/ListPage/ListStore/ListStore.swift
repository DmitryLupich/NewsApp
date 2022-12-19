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
    case detailsDismissed
    case didScrollToBottom
    case details(NewsModel)
    case onAppear(NewsModel)
    case loadedNews([NewsModel])
}

//MARK: - State

public struct ListState: Equatable {
    public var page: Int = 1
    public var news: [NewsModel]
    public var shouldShowDetails: Bool = false
    
    public init(news: [NewsModel]) {
        self.news = news
    }
}

//MARK: - Reducer

public let listReducer = Reducer<ListState, ListAction, ListEnvironment>
    .init { state, action, environment in
        switch action {
        case .start, .didScrollToBottom:
            return environment
                .newsService
                .news(for: state.page)
                .replaceError(with: [])
                .receive(on: DispatchQueue.main)
                .map { ListAction.loadedNews($0) }
                .eraseToEffect()
        case .loadedNews(let news):
            state.page += 1
            state.news += news
            return .none
        case .details:
            return .none
        case .onAppear(let post):
            return post == state.news.last ?
            Effect.init(value: ListAction.didScrollToBottom) : .none
        case .detailsDismissed:
            state.shouldShowDetails = false
            return .none
        }
    }

//MARK: - Environment

public struct ListEnvironment {
    public let newsService: NewsServiceProtocol
    
    public init(newsService: NewsServiceProtocol) {
        self.newsService = newsService
    }
}
