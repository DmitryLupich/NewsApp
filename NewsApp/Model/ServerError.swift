//
//  ServerError.swift
//  NewsApp
//
//  Created by Dmitriy Lupych on 7/8/19.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import Foundation

struct ServerError {
    let status: String
    let code: String
    let message: String
}

extension ServerError: Codable { }
