//
//  NewsModel.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/8/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import Foundation
import Utility

public struct NewsModel: Equatable, Identifiable, Codable {
    public let id: Int
    public let date: String
    public let contentRendered: ContentRendered
    public let titleRendered: TitleRendered
    public let featuredMedia: FeaturedImage?
    
    public static func ==(lhs: NewsModel, rhs: NewsModel) -> Bool {
        lhs.id == rhs.id
    }

    public static let mock: Self = .init(
        id: 1,
        date: "11:11:11",
        contentRendered: .init(content: "Content goes here"),
        titleRendered: .init(title: "Title Header"),
        featuredMedia: nil
    )

    private enum CodingKeys: String, CodingKey {
        case id, date
        case titleRendered = "title"
        case contentRendered = "content"
        case featuredMedia = "better_featured_image"
    }
}

public extension NewsModel {
    func preparedModel () -> NewsModel {
        var preparedContentRenderd = self.contentRendered
        preparedContentRenderd.content = self.contentRendered
            .content
            .removeHTMLTags()
        var preparedTitleRendered = self.titleRendered
        preparedTitleRendered.title = self.titleRendered
            .title
            .removeHTMLTags()
        return NewsModel(
            id: self.id,
            date: self.date,
            contentRendered: preparedContentRenderd,
            titleRendered: preparedTitleRendered,
            featuredMedia: self.featuredMedia
        )
    }
}

public struct TitleRendered: Codable {
    public var title: String
    private enum CodingKeys: String, CodingKey {
        case title = "rendered"
    }
}

public struct ContentRendered: Codable {
    public var content: String
    private enum CodingKeys: String, CodingKey {
        case content = "rendered"
    }
}

public struct FeaturedImage: Codable {
    public var fullSizeUrl: String
    private enum CodingKeys: String, CodingKey {
        case fullSizeUrl = "source_url"
    }
}
