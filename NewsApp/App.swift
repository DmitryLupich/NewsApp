//
//  App.swift
//  NewsApp
//
//  Created by Dmytro Lupych on 2/11/22.
//  Copyright © 2022 Dmitry Lupich. All rights reserved.
//

import SwiftUI
import Networking
import ComposableArchitecture

@main
struct NewsApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(
                store: .init(
                    initialState: .initial,
                    reducer: appReducer,
                    environment: .init(
                        networking: Networking(
                            session: .shared
                        )
                    )
                )
            )
        }
    }
}
