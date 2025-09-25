//
//  ContactsFeature.swift
//  Todo
//
//  Created by Oleh on 25.09.2025.
//

import Foundation
import ComposableArchitecture

struct Contact: Equatable, Identifiable, Sendable {
    let id: UUID
    var name: String
}

@Reducer
struct ContactsFeature {
    @ObservableState
    struct State: Equatable, Sendable {
        var contacts: IdentifiedArrayOf<Contact> = []
    }
    
    enum Action: Sendable {
        case addButtonTapped
    }
    
    func reduce(into state: inout State, action: Action) -> ComposableArchitecture.Effect<Action> {
        switch action {
        case .addButtonTapped:
            return .none
        }
    }
}
