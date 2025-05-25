//
//  MainApp.swift
//  Money-manager
//
//  Created by Oleksii Karas on 24.05.2025.
//

import SwiftUI
import ComposableArchitecture

@main
struct MainApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(
                store: Store(
                    initialState: AppReducer.State(),
                    reducer: { AppReducer() }
                )
            )
        }
    }
}
