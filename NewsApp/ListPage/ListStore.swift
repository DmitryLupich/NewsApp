//
//  ListStore.swift
//  NewsApp
//
//  Created by Dmytro Lupych on 2/8/22.
//  Copyright © 2022 Dmitry Lupich. All rights reserved.
//

import ComposableArchitecture
import Foundation

//MARK: - Action

public enum ListAction {
    case start
    case scrollToBottom
}

//MARK: - State

public struct ListState: Equatable {
    public var news: [String]
    
    public init(news: [String]) {
        self.news = news
    }
}

//MARK: - Reducer

let reducer = Reducer<ListState, ListAction, [String]>.init { state, action, environment in
    switch action {
    case .start:
        state.news = environment
        
    case .scrollToBottom:
        state.news += environment
    }
    return .none
}

//MARK: - Environment

public struct Environment {
    
}
