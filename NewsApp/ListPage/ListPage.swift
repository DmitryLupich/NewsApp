//
//  ListPage.swift
//  NewsApp
//
//  Created by Dmytro Lupych on 2/7/22.
//  Copyright © 2022 Dmitry Lupich. All rights reserved.
//

import SwiftUI
import Common
import Combine
import ComposableArchitecture

//MARK: - View

public struct ListView: View {
    private let store: Store<ListState, ListAction>
    
    public init(store: Store<ListState, ListAction>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            List(viewStore.news, id: \.id) { post in
                ListItem(model: .init(
                    imageURL: post.featuredMedia.flatMap { URL(string: $0.fullSizeUrl) },
                    title: post.titleRendered.title.removeHTMLTags(),
                    decription: post.contentRendered.content.removeHTMLTags())
                ).onTapGesture { viewStore.send(.details(post)) }
                .onAppear {
                    if post == viewStore.news.last {
                        viewStore.send(.scrollToBottomPage)
                    }
                }
            }
        }
    }
}
