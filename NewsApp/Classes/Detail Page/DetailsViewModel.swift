//
//  DetailsViewModel.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/9/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailsViewModel {

    // MARK: - Properties

    private let service: ServiceContract
    private let coordinator: MainCoordinator
    private let model: NewsModel

    // MARK: - Initialization

    init(service: ServiceContract,
         coordinator: MainCoordinator, 
         model: NewsModel) {
        self.service = service
        self.coordinator = coordinator
        self.model = model
    }
}

extension DetailsViewModel: ViewModelType {

    struct Input { }

    struct Output {
        let postComponents: Observable<[PostComponents]>
    }

    func transform(input: Input) -> Output {
        let postComponents = Observable.just(model.toPostComponentsAdapter())
        return Output(postComponents: postComponents)
    }
}
