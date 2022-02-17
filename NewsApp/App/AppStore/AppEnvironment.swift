//
//  AppEnvironment.swift
//  NewsApp
//
//  Created by Dmytro Lupych on 2/11/22.
//  Copyright © 2022 Dmitry Lupich. All rights reserved.
//

import Common
import Foundation
import ListPage

//MARK: - AppEnvironment

public struct AppEnvironment {
    public let listEnvironment: ListEnvironment
    private let networking: NetworkContract
    
    public init(networking: NetworkContract) {
        self.networking = networking
        let newsSerivce: NewsServiceContract = NewsService(network: networking)
        self.listEnvironment = .init(newsService: newsSerivce)
    }
}
