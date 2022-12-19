//
//  AppState.swift
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

//MARK: - Screens

//MARK: - App State

public struct AppState: Equatable {
    var shouldShowDetails: Bool
    var listState: ListState
    var detailsState: DetailsState
    
    static let initial: Self = .init(
        shouldShowDetails: false,
        listState: .init(news: []),
        detailsState: .init(post: .mock)
    )
}

//MARK: - App Action

public enum AppAction: Equatable {
    case list(ListAction)
}

//MARK: - App Reducer

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case .list(let listAction):
        switch listAction {
        case .details(let post):
            state.detailsState = .init(post: post)
            state.shouldShowDetails = true
            state.listState.shouldShowDetails = true
            return .none
        case .detailsDismissed:
            state.shouldShowDetails = false
            return .none
        default:
            return .none
        }
    }
}.combined(with:
            listReducer
    .pullback(state: \.listState,
              action: /AppAction.list,
              environment: { $0.listEnvironment })
)
