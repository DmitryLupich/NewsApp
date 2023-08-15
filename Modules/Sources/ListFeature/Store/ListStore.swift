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
    //MARK: - Environment
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
        public var isLoading: Bool = false

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
        case newsResponse(Result<[NewsModel], NAError>)
    }

    //MARK: - Reducer
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .start, .didScrollToBottom:
                state.isLoading = true
                return environment
                    .newsService
                    .news(for: state.page)
                    .receive(on: DispatchQueue.main)
                    .catchToEffect(Action.newsResponse)
            case let .newsResponse(.success(news)):
                state.isLoading = false
                state.page += 1
                state.news += news
                return .none
            case let .newsResponse(.failure(error)):
                state.isLoading = false
                //TODO: - Handle Error
                print("❇️ Error:", error.localizedDescription)
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
