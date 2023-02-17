//
//  DetailsPage.swift
//  NewsApp
//
//  Created by Dmytro Lupych on 2/21/22.
//  Copyright © 2022 Dmitry Lupich. All rights reserved.
//

import SwiftUI
import Kingfisher
import ComposableArchitecture

public struct DetailsPage: View {
    let store: Store<DetailsState, DetailsAction>

    public init(store: Store<DetailsState, DetailsAction>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            ScrollView {
                VStack(spacing: 16) {
                    Text(viewStore.state.title)
                        .font(.title)
                    KFImage(viewStore.imageUrl)
                        .placeholder { Color.random }
                        .frame(height: 256)
                    HStack(spacing: .zero) {
                        Text(viewStore.state.date)
                            .font(.subheadline)
                        Spacer()
                    }
                    Text(viewStore.state.content)
                        .font(.body)
                }
            }.padding(.horizontal, 16)
        }
    }
}

public extension DetailsPage {
    struct Model {
        public let imageURL: URL?
        public let title, description: String
        
        static let mock: Self = .init(
            imageURL: URL(string: "https://miuc.org/wp-content/uploads/2016/12/apple-intro.jpg"),
            title: "Test Title Test Title Test Title Test Title Test Title Test Title",
            description: "Test Description Test Description Test Description Test Description Test Description Test Description Test Description Test Description")
    }
}
