//
//  AppView.swift
//  NewsApp
//
//  Created by Dmytro Lupych on 2/11/22.
//  Copyright © 2022 Dmitry Lupich. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {
    let store: StoreOf<AppFeature>
    
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
                        action: AppFeature.Action.list
                    )
                )
                .onAppear {
                    viewStore.start()
                }
                .navigationDestination(for: AppFeature.State.Route.self) { route in
                    switch route {
                    case .details:
                        DetailsPage(
                            store: store.scope(
                                state: \.detailsState,
                                action: AppFeature.Action.details
                            )
                        )
                    }
                }
            }
        }
    }
}

fileprivate extension ViewStore<AppFeature.State, AppFeature.Action> {
    func start() {
        send(.list(.start))
    }
}
