//
//  ListPage.swift
//  NewsApp
//
//  Created by Dmytro Lupych on 2/7/22.
//  Copyright © 2022 Dmitry Lupich. All rights reserved.
//

import SwiftUI
import Combine
import ComposableArchitecture

//MARK: - View

public struct ListView: View {
    private let store: StoreOf<ListFeature>
    
    public init(store: StoreOf<ListFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            List(viewStore.news, id: \.id) { post in
                ListItem(model: .init(post: post))
                    .onTapGesture { viewStore.send(.details(post)) }
                    .onAppear { viewStore.send(.onAppear(post)) }
            }.toolbar {
                if viewStore.isLoading {
                    ProgressView()
                }
            }
        }
    }
}
