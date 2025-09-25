//
//  ContactsView.swift
//  Todo
//
//  Created by Oleh on 25.09.2025.
//

import SwiftUI
import ComposableArchitecture

struct ContactsView: View {
  let store: StoreOf<ContactsFeature>
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(store.contacts) { contact in
          Text(contact.name)
        }
      }
      .navigationTitle("Contacts")
      .toolbar {
        ToolbarItem {
          Button {
            store.send(.addButtonTapped)
          } label: {
            Image(systemName: "plus")
          }
        }
      }
    }
  }
}

#Preview {
    ContactsView(store: Store(initialState: ContactsFeature.State(), reducer: {
        ContactsFeature()
    }))
}
