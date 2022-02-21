//
//  AppState.swift
//  NewsApp
//
//  Created by Dmytro Lupych on 2/11/22.
//  Copyright © 2022 Dmitry Lupich. All rights reserved.
//

import Foundation
import Combine
import Common
import ComposableArchitecture
import ListPage
import SwiftUI

//MARK: - Screens

public enum AppScreen: Equatable {
    case list
    case details(NewsModel)
}

//MARK: - App State

public struct AppState: Equatable {
    var currentScreen: AppScreen
    
    var listState: ListState
    
    static let initial: Self = .init(
        currentScreen: .list,
        listState: .init(news: [])
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
            state.currentScreen = .details(post)
            return .none
        default:
            state.currentScreen = .list
            return .none
        }
    }
}.combined(with:
            listReducer
            .pullback(state: \.listState,
                      action: /AppAction.list,
                      environment: { $0.listEnvironment })
)
