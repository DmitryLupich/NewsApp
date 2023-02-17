//
//  AppStore.swift
//  NewsApp
//
//  Created by Dmytro Lupych on 2/11/22.
//  Copyright © 2022 Dmitry Lupich. All rights reserved.
//

import Common
import Combine
import SwiftUI
import ListPage
import Foundation
import DetailsPage
import ComposableArchitecture

//MARK: - App State

public struct AppState: Equatable {
    public enum Route: Hashable {
        case details
    }

    var path: [Route] = []
    var listState: ListState
    var detailsState: DetailsState
    
    static let initial: Self = .init(
        path: [],
        listState: .init(news: []),
        detailsState: .init(post: .mock)
    )
}

//MARK: - App Action

public enum AppAction: Equatable {
    case list(ListAction)
    case details(DetailsAction)
    case path([AppState.Route])
}

//MARK: - App Reducer

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
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
}.combined(with:
            listReducer
    .pullback(state: \.listState,
              action: /AppAction.list,
              environment: \.listEnvironment)
)
