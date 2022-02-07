//
//  ListItem.swift
//  ListPage
//
//  Created by Dmytro Lupych on 2/7/22.
//  Copyright © 2022 Dmitry Lupich. All rights reserved.
//


import Kingfisher
import SwiftUI

//MARK: - View

public struct ListItem: SwiftUI.View {
    private let model: Self.Model
    
    public init(model: Self.Model) {
        self.model = model
    }
    
    public var body: some SwiftUI.View {
        HStack(spacing: 8) {
            KFImage(model.imageURL)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(8)
                .clipped()
                .padding([.leading, .top, .bottom], 8)
            VStack(spacing: 8) {
                HStack {
                    Text(model.title)
                        .lineLimit(2)
                        .font(.system(size: 15))
                    Spacer()
                }
                HStack {
                    Text(model.decription)
                        .lineLimit(3)
                        .font(.system(size: 11))
                    Spacer()
                }
            }
        }
    }
}

//MARK: - Model

public extension ListItem {
    struct Model {
        public let imageURL: URL?
        public let title, decription: String
        
        static let mock: Self = .init(
            imageURL: URL(string: "https://miuc.org/wp-content/uploads/2016/12/apple-intro.jpg"),
            title: "Test Title Test Title Test Title Test Title Test Title Test Title",
            decription: "Test Description Test Description Test Description Test Description Test Description Test Description Test Description Test Description")
    }
}

//MARK: - Previews

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListItem(model: .mock)
    }
}
