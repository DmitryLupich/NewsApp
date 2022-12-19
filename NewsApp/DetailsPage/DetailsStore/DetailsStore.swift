//
//  DetailsStore.swift
//  DetailsPage
//
//  Created by Dmytro Lupych on 2/21/22.
//  Copyright © 2022 Dmitry Lupich. All rights reserved.
//

import Foundation
import Common

public struct DetailsState: Equatable {
    public let post: NewsModel

    public init(post: NewsModel) {
        self.post = post
    }
}

public enum DetailsAction: Equatable {}

