//
//  Rx+Extensions.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 06.05.2020.
//  Copyright © 2020 Dmitry Lupich. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - Divide materialized sequence to .errors() and .elememts()

extension ObservableType where E: EventConvertible {
    func elements() -> Observable<E.ElementType> {
        flatMap { value -> Observable<E.ElementType> in
            guard let element = value.event.element else { return .empty() }
            return Observable.just(element)
        }
    }

    func errors() -> Observable<Error> {
        flatMap { value -> Observable<Error> in
            guard let error = value.event.error else { return .empty() }
            return Observable.just(error)
        }
    }
}
