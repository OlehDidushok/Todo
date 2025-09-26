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
            ContactsView(store: Store(initialState: ContactsFeature.State()) {
                ContactsFeature()
            })
        }
    }
}
