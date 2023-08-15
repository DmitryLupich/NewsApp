//
//  AppStore.swift
//  NewsApp
//
//  Created by Dmytro Lupych on 2/11/22.
//  Copyright © 2022 Dmitry Lupich. All rights reserved.
//

import Combine
import SwiftUI
import Foundation
import ListFeature
import DetailsFeature
import ComposableArchitecture

public struct AppFeature: ReducerProtocol {
    //MARK: - State
    
    public struct State: Equatable {
        public enum Route: Hashable {
            case details
        }

        var path: [Route] = []
        var listState: ListFeature.State
        var detailsState: DetailsFeature.State?

        static let initial: Self = .init(
            path: [],
            listState: .init(news: []),
            detailsState: .none
        )
    }

    //MARK: - Action

    public enum Action: Equatable {
        case list(ListFeature.Action)
        case details(DetailsFeature.Action)
        case path([State.Route])
    }

    //MARK: - Reducer

    public var body: some ReducerProtocolOf<Self> {
        Reduce { state, action in
            switch action {
            case let .list(.details(post)):
                state.detailsState = .init(post: post)
                state.path = [.details]
                return .none
            case .path(let newPath):
                state.path = newPath
                return .none
            default:
                return .none
            }
        }
        
        Scope(
            state: \.listState,
            action: /Action.list
        ) {
            ListFeature()
        }
    }
}
