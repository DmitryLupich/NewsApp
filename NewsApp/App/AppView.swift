//
//  AppView.swift
//  NewsApp
//
//  Created by Dmytro Lupych on 2/11/22.
//  Copyright © 2022 Dmitry Lupich. All rights reserved.
//

import ListPage
import SwiftUI
import ComposableArchitecture

struct AppView: View {
    let store: Store<AppState, AppAction>
    
    var body: some View {
        WithViewStore.init(self.store) { viewStore in
            ListView(store: store.scope(
                state: \.listState,
                action: AppAction.list)
            ).onAppear {
                viewStore.start()
            }
        }
    }
}

fileprivate extension ViewStore<AppState, AppAction> {
    func start() {
        send(.list(.start))
    }
}
