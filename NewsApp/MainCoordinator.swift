//
//  MainCoordinator.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/8/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    private let service = NewsService(network: Networking(session: .init(configuration: .default)))
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
