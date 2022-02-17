//
//  String+Extensions.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/12/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import Foundation

public extension String {
    static let empty: String = .init()
    
    func removeHTMLTags() -> String {
        return self.replacingOccurrences(of: "<[^>]+>",
                                         with: "",
                                         options: .regularExpression,
                                         range: nil)
    }
    
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ru_UA")
        dateFormatter.dateStyle = DateFormatter.Style.medium
        guard
            let dateOfTypeDate = dateFormatter.date(from: self)
        else { return "" }
        let stringDate = dateFormatter
            .string(from: dateOfTypeDate)
            .lowercased()
        return stringDate
    }
}
