//
//  DetailsViewModel.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/9/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import Foundation

final class DetailsViewModel {

    // MARK: - Private Properties

    private let service: ServiceContract
    private let coordinator: MainCoordinator
    private let model: NewsModel

    // MARK: - Public Properties

    public var dataSourceCount: Int {
        return model.toPostComponentsAdapter().count
    }

    public var postComponentes: [PostComponents] {
        return model.toPostComponentsAdapter()
    }

    // MARK: - Initialization

    init(service: ServiceContract,
         coordinator: MainCoordinator, 
         model: NewsModel) {
        self.service = service
        self.coordinator = coordinator
        self.model = model
    }
}
