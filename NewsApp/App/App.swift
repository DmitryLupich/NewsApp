//
//  App.swift
//  NewsApp
//
//  Created by Dmytro Lupych on 2/11/22.
//  Copyright © 2022 Dmitry Lupich. All rights reserved.
//

import Common
import ComposableArchitecture
import ListPage
import SwiftUI

@main
struct NewsApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(
                store: Store(
                    initialState: .initial,
                    reducer: appReducer,
                    environment: .init(networking: Networking(session: .shared))
                )
            )
        }
    }
}
