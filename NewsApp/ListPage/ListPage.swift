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
    private let store: ViewStore<ListState, ListAction>
    
    public init(store: ViewStore<ListState, ListAction>) {
        self.store = store
    }
    
    public var body: some View {
        Text(store.state.news.joined(separator: ""))
    }
}

//MARK: - Previews

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(
            store: .init(
                .init(
                    initialState: .init(news: ["news 0, news 1, news 2, news 3"]),
                    reducer: reducer,
                    environment: ["news 0, news 1, news 2, news 3"])
            )
        )
    }
}
