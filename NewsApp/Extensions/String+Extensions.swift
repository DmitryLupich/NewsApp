//
//  String+Extensions.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/12/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import Foundation

public extension String {
    func removeHTMLTags() -> String {
        return self.replacingOccurrences(of: "<[^>]+>",
                                         with: "",
                                         options: .regularExpression,
                                         range: nil)
    }
}
