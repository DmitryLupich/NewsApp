//
//  NewsService.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/8/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import Foundation

// MARK: - Service Contract

protocol ServiceContract {
    func latestNews<T: Decodable>(endPoint: Endpoint,
                                  completion: @escaping (Result<[T], Error>) -> Void)
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

    func latestNews<T: Decodable>(endPoint: Endpoint,
                                  completion: @escaping (Result<[T], Error>) -> Void) {
        guard
            let url = URL(string: endPoint.path)
            else { completion(Result.failure(NAError.badUrl))
                return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.httpMethod

        session.dataTask(with: request) { (data, response, error) in

            if let error = error {
                completion(Result.failure(error))
            }

            if let response = response as? HTTPURLResponse, let data = data {
                completion(self.handle(serverResponse: (response: response, data: data)))
            }
            }
            .resume()
    }
}

// MARK: - Private Methods

extension NewsService {
    private func handle<T: Decodable>(serverResponse: (response: HTTPURLResponse, data: Data))
        -> Result<[T], Error> {
            switch serverResponse.response.statusCode {
            case 200..<300:
                do {
                    let model: [T] = try
                        self.jsonDecoder.decode([T].self,
                                                from: serverResponse.data)
                    return Result.success(model)
                }
                catch {
                    return Result.failure(NAError.mapping)
                }
                //TODO: - Handle other statusCodes
                //and map server errors from serverResponse.data if needed
            //REFERENCE https://www.restapitutorial.com/httpstatuscodes.html
            default:
                return Result.failure(NAError.generic)
            }
    }
}
