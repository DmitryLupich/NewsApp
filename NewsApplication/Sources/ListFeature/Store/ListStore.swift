//
//  ListStore.swift
//  NewsApp
//
//  Created by Dmytro Lupych on 2/8/22.
//  Copyright © 2022 Dmitry Lupich. All rights reserved.
//

import Models
import Service
import Foundation
import Networking
import ComposableArchitecture

public struct ListFeature: ReducerProtocol {
    private let environment: ListEnvironment = .init(
        newsService: NewsService(
            network: Networking(
                session: .shared
            )
        )
    )

    //MARK: - State

    public struct State: Equatable {
        public var page: Int = 1
        public var news: [NewsModel]

        public init(news: [NewsModel]) {
            self.news = news
        }
    }

    //MARK: - Action
    public enum Action: Equatable {
        case start
        case didScrollToBottom
        case details(NewsModel)
        case onAppear(NewsModel)
        case loadedNews([NewsModel])
    }

    //MARK: - Reducer

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .start, .didScrollToBottom:
                return environment
                    .newsService
                    .news(for: state.page)
                    .replaceError(with: [])
                    .receive(on: DispatchQueue.main)
                    .map { Action.loadedNews($0) }
                    .eraseToEffect()
            case .loadedNews(let news):
                state.page += 1
                state.news += news
                return .none
            case .details:
                return .none
            case .onAppear(let post):
                return post == state.news.last ?
                EffectTask(value: Action.didScrollToBottom) : .none
            }
        }
    }

    public init() {}
}
