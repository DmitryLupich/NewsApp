//
//  NewsService.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/8/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - Service Contract

protocol ServiceContract {
    func latestNews<T: Decodable>(endPoint: Endpoint) -> Observable<[T]>
}

// MARK: - News Service

final class NewsService {
    internal let jsonDecoder = JSONDecoder()
    private let session: URLSession
    init(session: URLSession) {
        self.session = session
    }
}

// MARK: - Protocol Methods

extension NewsService: ServiceContract {

    func latestNews<T: Decodable>(endPoint: Endpoint) -> Observable<[T]> {
        guard let url = URL(string: endPoint.path) else { return Observable.error(NAError.badUrl) }
        
        let request = URLRequest(url: url)
        
        return session.rx
            .response(request: request)
            .map { serverResponse in
                try self.handle(serverResponse: serverResponse)
            }
            .retry(3)
            .catchErrorJustReturn([])
    }
}

// MARK: - Private Methods

extension NewsService {
    private func handle<T: Decodable>(serverResponse: (response: HTTPURLResponse, data: Data)) throws -> [T] {
        switch serverResponse.response.statusCode {
        case 200..<300:
            do {
                let model: [T] = try
                    self.jsonDecoder.decode([T].self,
                                            from: serverResponse.data)
                return model
            }
            catch {
                throw NAError.mapping
            }
            //TODO: - handle other statusCodes and map server errors if needed
        //REFERENCE https://www.restapitutorial.com/httpstatuscodes.html
        default:
            throw NAError.generic
        }
    }
}
