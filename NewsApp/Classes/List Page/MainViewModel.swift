//
//  MainViewModel.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/8/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import Foundation

final class MainViewModel {
    
    // MARK: - Private Properties
    
    private let storage = StorageManager()
    private let service: ServiceContract
    private let coordinator: MainCoordinator
    private var isServiceAvaliable = true
    private var dataSource = [NewsModel]()
    private var page: Int = 1 {
        didSet {
            if isServiceAvaliable {
                loadModels(page: page)
            }
        }
    }
    
    // MARK: - Public Properties
    
    public var dataSourceCount: Int {
        return dataSource.count
    }
    
    public var publicDataSource: [NewsModel] {
        return dataSource.map { $0.preparedModel() }
    }

    public var render: ((ListModel) -> Void)?
    
    // MARK: - Initialization
    
    init(service: ServiceContract,
         coordinator: MainCoordinator) {
        self.service = service
        self.coordinator = coordinator
    }
}

// MARK: - Public Methods

extension MainViewModel {

    public func start() {
        isServiceAvaliable = true
        page = 1
    }
    
    public func rowChanged(_ row: Int) {
        if row == dataSource.count - 3 {
            page += 1
        }
    }

    public func selected(_ index: Int) {
        coordinator.toDetails(dataSource[index])
    }
}

// MARK: - Private Methods

extension MainViewModel {

    private func loadModels(page: Int) {
        service.latestNews(endPoint: Endpoint.latestNews(page: page))
        { [unowned self] (result: Result<[NewsModel], Error>) in
            DispatchQueue.main.async {
                self.render?(.isLoading(false))
                switch result {
                case .success(let models):
                    self.handleSuccess(models)
                case .failure(let error):
                    self.handleFailure(error)
                }
            }
        }
    }

    private func handleSuccess(_ models: [NewsModel]) {
        isServiceAvaliable = true
        dataSource = (page == 1) ? models : dataSource + models
        storage.write(models: dataSource)
        render?(.data)
    }

    private func handleFailure( _ error: Error) {
        isServiceAvaliable = false
        dataSource = storage.read(modelType: NewsModel.self)
        render?(.data)
        //TODO: - Optionaly show error to the user
        //render?(.error(error))
    }
}

// MARK: - Rendering State

extension MainViewModel {
    enum ListModel {
        case data
        case isLoading(Bool)
        case error(Error)
    }
}
