//
//  NewsModel.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/8/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import Foundation

typealias Identifier = Int

struct NewsModel {
    
    let id: Int
    let date: String
    let contentRendered: ContentRendered
    let titleRendered: TitleRendered
    let featuredMedia: FeaturedImage
}

extension NewsModel: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case id, date
        case titleRendered = "title"
        case contentRendered = "content"
        case featuredMedia = "better_featured_image"
    }
}

extension NewsModel {
    func preparedModel () -> NewsModel {
        var preparedContentRenderd = self.contentRendered
        preparedContentRenderd.content = self.contentRendered
            .content
            .removeHTMLTags()
        var preparedTitleRendered = self.titleRendered
        preparedTitleRendered.title = self.titleRendered
            .title
            .removeHTMLTags()
        return NewsModel(id: self.id,
                         date: self.date,
                         contentRendered: preparedContentRenderd,
                         titleRendered: preparedTitleRendered,
                         featuredMedia: self.featuredMedia)
    }
}

extension NewsModel {
    func toPostComponentsAdapter() -> [PostComponents] {
        return [PostComponents.title(self.titleRendered.title),
                PostComponents.title(self.date.formattedDate()),
                PostComponents.image(self.featuredMedia.fullSizeUrl),
                PostComponents.content(self.contentRendered.content)]
    }
}

struct TitleRendered: Codable {
    var title: String
    private enum CodingKeys: String, CodingKey {
        case title = "rendered"
    }
}

struct ContentRendered: Codable {
    var content: String
    private enum CodingKeys: String, CodingKey {
        case content = "rendered"
    }
}

struct FeaturedImage: Codable {
    var fullSizeUrl: String
    private enum CodingKeys: String, CodingKey {
        case fullSizeUrl = "source_url"
    }
}
