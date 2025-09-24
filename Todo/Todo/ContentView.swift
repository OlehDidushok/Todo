//
//  ContentView.swift
//  Todo
//
//  Created by Oleh on 24.09.2025.
//

import SwiftUI
import ComposableArchitecture

struct CounterFeature: Reducer {
    func reduce(into state: inout State, action: Action) -> ComposableArchitecture.Effect<Action> {
        switch action {
            
        case .decrementButtonTapped:
            state.count -= 1
            return .none
            
        case .incrementButtonTapped:
            state.count += 1
            return .none
            
        case .getFactButtonTapped:
            return .none
            
        case .toggleTimerButtonTapped:
            state.isTimerOn.toggle()
            return .none
        }
    }
    
    @ObservableState
    struct State: Equatable, Sendable {
        var count = 0
        var fact: String?
        var isTimerOn = false
    }
    
    enum Action: Sendable {
        case decrementButtonTapped
        case getFactButtonTapped
        case incrementButtonTapped
        case toggleTimerButtonTapped
    }
}

struct ContentView: View {
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        Form {
            Section {
                Text("\(store.count)")
                Button("Decrement") {
                    store.send(.decrementButtonTapped)
                }
                Button("Increment") {
                    store.send(.incrementButtonTapped)
                }
            }
            Section {
                Button("Get fact") {
                    store.send(.getFactButtonTapped)
                }
                if let fact = store.fact {
                    Text(fact)
                }
            }
            Section {
                if store.isTimerOn {
                    Button("Stop timer") {
                        store.send(.toggleTimerButtonTapped)
                    }
                } else {
                    Button("Start timer") {
                        store.send(.toggleTimerButtonTapped)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView(
        store: Store(initialState: CounterFeature.State()) {
            CounterFeature()
        }
    )
}

