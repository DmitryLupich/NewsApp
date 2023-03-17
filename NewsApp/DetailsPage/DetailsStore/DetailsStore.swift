//
//  DetailsStore.swift
//  DetailsPage
//
//  Created by Dmytro Lupych on 2/21/22.
//  Copyright © 2022 Dmitry Lupich. All rights reserved.
//

import Foundation

//MARK: - Details State

public struct DetailsState: Equatable {
    private let post: NewsModel

    public init(post: NewsModel) {
        self.post = post
    }

    var title: String {
        post.titleRendered.title.removeHTMLTags()
    }

    var imageUrl: URL? {
        post.featuredMedia.flatMap { URL(string: $0.fullSizeUrl) }
    }

    var date: String {
        post.date
    }

    var content: String {
        post.contentRendered.content.removeHTMLTags()
    }
}

//MARK: - Details Action

public enum DetailsAction: Equatable {}
