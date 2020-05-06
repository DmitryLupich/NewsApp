//
//  MainCoordinator.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/8/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class MainCoordinator: Coordinator {
    
    private let service = NewsService(session: URLSession(configuration: .default))
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Start Coordinator
    
    func start() {
        let mainViewModel = MainViewModel(service: service, coordinator: self)
        let mainController = NAMainViewController(viewModel: mainViewModel)
        navigationController.pushViewController(mainController, animated: true)
    }

    // MARK: - Navigate To Details Screen

    func toDetails(_ model: NewsModel) {
        let detailsViewModel = DetailsViewModel(service: service,
                                                coordinator: self,
                                                model: model)
        let detailsController = NADetailsViewController(viewModel: detailsViewModel)
        navigationController.pushViewController(detailsController, animated: true)
    }

    // MARK: - Navigate back a.k.a Pop Controller

    func back() {
        navigationController.popViewController(animated: true)
    }
}

extension MainCoordinator: ReactiveCompatible {}

extension Reactive where Base: MainCoordinator {
    var toDetails: Binder<NewsModel> {
        return Binder(base) { coordinator, newsmModel in
            coordinator.toDetails(newsmModel)
        }
    }
}
