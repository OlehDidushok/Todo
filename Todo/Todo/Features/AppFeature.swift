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

    func reduce(into state: inout State, action: Action) -> ComposableArchitecture.Effect<Action> {
        switch action {
        case let .tab1(childAction):
            return CounterFeature()
                .reduce(into: &state.tab1, action: childAction)
                .map(Action.tab1)

        case let .tab2(childAction):
            return CounterFeature()
                .reduce(into: &state.tab2, action: childAction)
                .map(Action.tab2)
        }
    }
}
