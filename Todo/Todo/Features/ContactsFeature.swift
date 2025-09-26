//
//  ContactsFeature.swift
//  Todo
//
//  Created by Oleh on 25.09.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ContactsFeature {
    @ObservableState
    struct State: Equatable, Sendable {
        @Presents var addContact: AddContactFeature.State?
        var contacts: IdentifiedArrayOf<Contact> = []
    }
    
    enum Action: Equatable, Sendable {
        case addButtonTapped
        case addContact(PresentationAction<AddContactFeature.Action>)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                state.addContact = AddContactFeature.State(
                    contact: Contact(id: UUID(), name: "")
                )
                return .none
                
            case .addContact(.presented(.cancelButtonTapped)):
                state.addContact = nil
                return .none
                
            case .addContact(.presented(.saveButtonTapped)):
                guard let contact = state.addContact?.contact else { return .none }
                state.contacts.append(contact)
                state.addContact = nil
                return .none
                
            case .addContact:
                return .none
            }
        }
        .ifLet(\.$addContact, action: \.addContact) {
            AddContactFeature()
        }
    }
}
