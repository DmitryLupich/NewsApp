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

    private let storage = StorageManager()
    private let service: ServiceContract
    private let coordinator: MainCoordinator
    private let newsDataSource = BehaviorRelay<[NewsModel]>(value: [])
    private let currentPage = BehaviorRelay<Int>(value: 0)
    private let loadNextSubject = PublishSubject<Void>()
    private let isServiceAvaliableSubject = PublishSubject<Bool>()
    private let errorSubject = PublishSubject<String>()
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialization
    
    init(service: ServiceContract,
         coordinator: MainCoordinator) {
        self.service = service
        self.coordinator = coordinator
    }
    
    // MARK: - Transform function
    
    func transform(input: MainViewModel.Input) -> MainViewModel.Output {
        
        input.onSelectedModel.observeOn(MainScheduler.instance)
            .bind { [unowned self] model in
                self.coordinator.toDetails(model)
            }.disposed(by: disposeBag)
        
        let loader = ActivityIndicator()
        let isLoading = loader.asObservable()
        let refreshTrigger = input.onRefresh.share()

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
        
        isLoadNext.flatMap({ isTriggered -> Observable<Void> in
            return isTriggered ? .just(()) : .empty()
        })
            .bind(to: loadNextSubject)
            .disposed(by: disposeBag)
        
        preparedModels.subscribeOn(MainScheduler.instance)
            .subscribe { [unowned self] (event) in
                switch event {
                case .next(let news):
                    self.handleNext(news: news)
                case .error(let error):
                    self.handleError(error: error)
                case .completed:
                    Logger.log(message: #function, value: "completed", logType: .info)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(news: newsDataSource.asObservable(),
                      isLoading: isLoading.share(),
                      errorMessage: errorSubject.asObservable())
    }
}

// MARK: - Methods

extension MainViewModel {
    private func handleNext(news: [NewsModel]) {
        if news.isNotEmpty {
            isServiceAvaliableSubject.onNext(true)
            let allNews = newsDataSource.value + news
            newsDataSource.accept(allNews)
            storage.write(models: allNews)
        } else {
            isServiceAvaliableSubject.onNext(false)
            newsDataSource.accept(storage.read(modelType: NewsModel.self))
        }
    }

    private func handleError(error: Error) {
        if let error = error as? NAError {
            self.errorSubject.onNext(error.localizedDescription)
        }
        errorSubject.onNext(error.localizedDescription)
        newsDataSource.accept(storage.read(modelType: NewsModel.self))
    }
}
