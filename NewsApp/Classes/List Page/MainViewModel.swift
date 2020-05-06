//
//  MainViewModel.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/8/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class MainViewModel: ViewModelType {
    
    struct Input {
        let didLoad:         Observable<Void>
        let lastCellIndex:   Observable<Int>
        let onRefresh:       Observable<Void>
        let onSelectedModel: Observable<NewsModel>
    }
    
    struct Output {
        let news:         Observable<[NewsModel]>
        let isLoading:    Observable<Bool>
        let errorMessage: Observable<String>
    }
    
    // MARK: - Properties

    private let storage = StorageManager(filteRouter: .news)
    private let service: ServiceContract
    private let coordinator: MainCoordinator
    private let newsDataSource = BehaviorRelay<[NewsModel]>(value: [])
    private let currentPage = BehaviorRelay<Int>(value: 0)
    private let loadNextSubject = PublishSubject<Void>()
    private let isServiceAvaliableSubject = PublishSubject<Bool>()
    private let errorSubject = PublishSubject<String>()
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialization
    
    init(service: ServiceContract, coordinator: MainCoordinator) {
        self.service = service
        self.coordinator = coordinator
    }
    
    // MARK: - Transform function
    
    func transform(input: MainViewModel.Input) -> MainViewModel.Output {
        
        input.onSelectedModel
            .observeOn(MainScheduler.instance)
            .bind(to: coordinator.rx.toDetails)
            .disposed(by: disposeBag)
        
        let loader = ActivityIndicator()
        let isLoading = loader.asObservable()
        let refreshTrigger = input.onRefresh

        refreshTrigger.bind { [unowned self] _ in
            self.currentPage.accept(1)
            self.newsDataSource.accept([])
        }.disposed(by: disposeBag)
        
        let loadingTrigger = Observable.merge(input.didLoad,
                                              loadNextSubject.asObservable())
        
        loadingTrigger.bind { [unowned self] _ in
            self.currentPage.accept(self.currentPage.value + 1)
        }.disposed(by: disposeBag)
        
        let newsResponse: Observable<[NewsModel]> = currentPage
            .asObservable()
            .flatMap { [unowned self] page in
                return self.service
                    .latestNews(endPoint: Endpoint.latestNews(page: page))
                    .trackActivity(loader)
                    .do(onNext: { [unowned self] (news) in
                        self.doOnNext(news)
                    })
                    .catchError { [unowned self] error in
                        return self.handle(error)
                }
        }

        let preparedModels: Observable<[NewsModel]> = newsResponse
            .map { models in
                return models.map { $0.preparedModel() }
        }
        
        let newsCount = newsDataSource.map { $0.count }
        let lastCellIndex = input.lastCellIndex
        
        let isLoadNext = Observable
            .combineLatest(lastCellIndex,
                           newsCount,
                           isServiceAvaliableSubject.asObservable())
            { last, count, isAvaliable in
                return isAvaliable ? last == count - 5 : false
        }
        
        isLoadNext.flatMap { isTriggered -> Observable<Void> in
            return isTriggered ? .just(()) : .empty()
        }
        .bind(to: loadNextSubject)
        .disposed(by: disposeBag)
        
        preparedModels
            .subscribeOn(MainScheduler.instance)
            .bind { [unowned self] news in
                let allNews = self.newsDataSource.value + news
                self.newsDataSource.accept(allNews)
        }.disposed(by: disposeBag)
        
        return Output(news: newsDataSource.asObservable(),
                      isLoading: isLoading,
                      errorMessage: errorSubject.asObservable())
    }
}

// MARK: - Methods

extension MainViewModel {
    private func doOnNext(_ news: [NewsModel]) {
        isServiceAvaliableSubject.onNext(true)
        let allNews = newsDataSource.value + news
        storage.write(models: allNews)
    }

    private func handle(_ error: Error) -> Observable<[NewsModel]> {
        isServiceAvaliableSubject.onNext(false)
        let models = storage.read(modelType: NewsModel.self)
        let isDataSourceEmpty = newsDataSource.value.isEmpty
        return isDataSourceEmpty ? Observable.just(models) : .empty()
    }
}
