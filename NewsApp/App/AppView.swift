//
//  AppView.swift
//  NewsApp
//
//  Created by Dmytro Lupych on 2/11/22.
//  Copyright © 2022 Dmitry Lupich. All rights reserved.
//

import ListPage
import SwiftUI
import DetailsPage
import ComposableArchitecture

struct AppView: View {
    let store: Store<AppState, AppAction>
    
    var body: some View {
        WithViewStore.init(self.store) { viewStore in
            NavigationStack(
                path: viewStore.binding(
                    get: \.path,
                    send: .path([])
                )
            ) {
                ListView(
                    store: store.scope(
                        state: \.listState,
                        action: AppAction.list
                    )
                )
                .onAppear {
                    viewStore.start()
                }
                .navigationDestination(for: AppState.Route.self) { route in
                    switch route {
                    case .details:
                        DetailsPage(
                            store: store.scope(
                                state: \.detailsState,
                                action: AppAction.details
                            )
                        )
                    }
                }
            }
        }
    }
}

fileprivate extension ViewStore<AppState, AppAction> {
    func start() {
        send(.list(.start))
    }
}
