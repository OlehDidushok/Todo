//
//  TodoApp.swift
//  Todo
//
//  Created by Oleh on 24.09.2025.
//

import SwiftUI
import ComposableArchitecture

@main
struct TodoApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(store: Store(initialState: AppFeature.State()) {
                AppFeature()
            })
        }
    }
}
