//
//  AddContactFeature.swift
//  Todo
//
//  Created by Oleh on 25.09.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AddContactFeature {
    @ObservableState
    struct State: Equatable {
        var contact: Contact
    }
    enum Action {
        case cancelButtonTapped
        case saveButtonTapped
        case setName(String)
    }
    
    func reduce(into state: inout State, action: Action) -> ComposableArchitecture.Effect<Action> {
        switch action {
        case .cancelButtonTapped:
            return .none
        case .saveButtonTapped:
            return .none
        case .setName(let name):
            state.contact.name = name
            return .none
        }
    }
}
