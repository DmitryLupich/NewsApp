//
//  DetailsPage.swift
//  NewsApp
//
//  Created by Dmytro Lupych on 2/21/22.
//  Copyright © 2022 Dmitry Lupich. All rights reserved.
//

import Kingfisher
import SwiftUI


public struct DetailsPage: View {
    public var body: some View {
        VStack {
            Text("")
        }
    }
}

public extension DetailsPage {
    struct Model {
        public let imageURL: URL?
        public let title, decription: String
        
        static let mock: Self = .init(
            imageURL: URL(string: "https://miuc.org/wp-content/uploads/2016/12/apple-intro.jpg"),
            title: "Test Title Test Title Test Title Test Title Test Title Test Title",
            decription: "Test Description Test Description Test Description Test Description Test Description Test Description Test Description Test Description")
    }
}
