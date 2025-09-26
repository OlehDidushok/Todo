//
//  AppFeature.swift
//  Todo
//
//  Created by Oleh on 25.09.2025.
//

import ComposableArchitecture
import CasePaths

@Reducer
struct AppFeature {
    @ObservableState
    struct State: Equatable, Sendable {
        var tab1 = CounterFeature.State()
        var tab2 = CounterFeature.State()
    }
    
    @CasePathable
    enum Action: Sendable {
        case tab1(CounterFeature.Action)
        case tab2(CounterFeature.Action)
    }
    
    var body: some Reducer<State, Action> {
        Scope(state: \.tab1, action: \.tab1) {
            CounterFeature()
        }
        Scope(state: \.tab2, action: \.tab2) {
            CounterFeature()
        }
        Reduce { state, action in
            return .none
        }
    }
}
