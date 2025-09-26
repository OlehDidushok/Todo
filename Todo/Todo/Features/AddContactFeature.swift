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
    struct State: Equatable, Sendable {
        var contact: Contact
    }
    enum Action: Equatable, Sendable {
        case cancelButtonTapped
        case saveButtonTapped
        case setName(String)
    }
    
    var body: some Reducer<State, Action> {
           Reduce { state, action in
               switch action {
               case .cancelButtonTapped:
                   return .none
                   
               case .saveButtonTapped:
                   return .none
                   
               case let .setName(name):
                   state.contact.name = name
                   return .none
               }
           }
       }
}

