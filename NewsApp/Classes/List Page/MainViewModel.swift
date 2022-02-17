////
////  MainViewModel.swift
////  NewsApp
////
////  Created by Dmitriy Lupych on 7/8/19.
////  Copyright © 2019 Dmitry Lupich. All rights reserved.
////
//
//import Common
//import Combine
//import Foundation
//
//final class MainViewModel {
//    
//    // MARK: - Private Properties
//    
//    private var cancellables = Set<AnyCancellable>()
//    private let storage = StorageManager()
//    private let service: NewsServiceContract
//    private let coordinator: MainCoordinator
//    private var isServiceAvaliable = true
//    private var dataSource = [NewsModel]()
//    private var page: Int = 1 {
//        didSet {
//            if isServiceAvaliable {
//                loadModels(page: page)
//            }
//        }
//    }
//    
//    // MARK: - Public Properties
//    
//    public var dataSourceCount: Int {
//        return dataSource.count
//    }
//    
//    public var publicDataSource: [NewsModel] {
//        return dataSource.map { $0.preparedModel() }
//    }
//    
//    public var render: ((ListModel) -> Void)?
//    
//    // MARK: - Initialization
//    
//    init(service: NewsServiceContract,
//         coordinator: MainCoordinator) {
//        self.service = service
//        self.coordinator = coordinator
//    }
//}
//
//// MARK: - Public Methods
//
//extension MainViewModel {
//    
//    public func start() {
//        isServiceAvaliable = true
//        page = 1
//    }
//    
//    public func rowChanged(_ row: Int) {
//        if row == dataSource.count - 3 {
//            page += 1
//        }
//    }
//    
//    public func selected(_ index: Int) {
//        coordinator.toDetails(dataSource[index])
//    }
//}
//
//// MARK: - Private Methods
//
//extension MainViewModel {
//    
//    private func loadModels(page: Int) {
//        weak var weakSelf = self
//        service.latestNews(endpoint: Endpoint.latestNews(page: page))
//            .receive(on: DispatchQueue.main)
//            .sink { completion in
//                switch completion {
//                case .finished:
//                    Logger.log(value: "Finished")
//                case .failure(let error):
//                    weakSelf?.handleFailure(error)
//                }
//            } receiveValue: { news in
//                weakSelf?.handleSuccess(news)
//            }
//            .store(in: &cancellables)
//    }
//    
//    private func handleSuccess(_ models: [NewsModel]) {
//        isServiceAvaliable = true
//        dataSource = (page == 1) ? models : dataSource + models
//        storage.write(models: dataSource)
//        render?(.data)
//    }
//    
//    private func handleFailure( _ error: NAError) {
//        isServiceAvaliable = false
//        dataSource = storage.read(modelType: NewsModel.self)
//        render?(.data)
//        //TODO: - Optionaly show error to the user
//        //render?(.error(error))
//    }
//}
//
//// MARK: - Rendering State
//
//extension MainViewModel {
//    enum ListModel {
//        case data
//        case isLoading(Bool)
//        case error(Error)
//    }
//}
