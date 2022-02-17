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
            VStack {
                switch viewStore.state.currentScreen {
                case .list:
                    ListView(store: store.scope(
                        state: \.listState,
                        action: AppAction.list)
                    )
                case .details:
                    VStack {
                        Text("This is details screen")
                        Button {
                            viewStore.send(.list(.start))
                        } label: {
                            Text("To list")
                        }
                    }
                }
            }.onAppear {
                viewStore.send(.list(.start))
            }
        }
    }
}
