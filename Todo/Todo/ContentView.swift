//
//  ContentView.swift
//  Todo
//
//  Created by Oleh on 24.09.2025.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct CounterFeature {
    func reduce(into state: inout State, action: Action) -> ComposableArchitecture.Effect<Action> {
        switch action {
            
        case .decrementButtonTapped:
            state.count -= 1
            state.fact = nil
            return .none
            
        case .incrementButtonTapped:
            state.count += 1
            state.fact = nil
            return .none
            
        case .getFactButtonTapped:
            state.isLoading = true
            let count = state.count
            return .run { [count] send in
                let title = "\(count)_(number)".addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "\(count)_(number)"
                var req = URLRequest(url: URL(string: "https://en.wikipedia.org/api/rest_v1/page/summary/\(title)")!)
                req.setValue("TodoApp/1.0 (example)", forHTTPHeaderField: "User-Agent")

                let res = try? await URLSession.shared.data(for: req)
                let http = res?.1 as? HTTPURLResponse
                let ok = (http?.statusCode ?? 0) >= 200 && (http?.statusCode ?? 0) < 300

                let extract: String? = ok
                    ? (((try? JSONSerialization.jsonObject(with: res?.0 ?? Data())) as? [String: Any])?["extract"] as? String)
                    : nil

                await send(.factResponse((extract?.isEmpty == false ? extract : nil) ?? "No info found for \(count)."))
            }
            
        case let .factResponse(fact):
                state.fact = fact
                state.isLoading = false
                return .none
            
        case .toggleTimerButtonTapped:
            state.isTimerRunning.toggle()
            return .none
        }
    }
    
    @ObservableState
    struct State: Equatable, Sendable {
        var count = 0
        var fact: String?
        var isTimerRunning = false
        var isLoading = false
    }
    
    enum Action: Sendable {
        case decrementButtonTapped
        case getFactButtonTapped
        case factResponse(String)
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
                if store.isLoading {
                    ProgressView()
                } else if let fact = store.fact {
                    Text(fact)
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
            Section {
                Button(store.isTimerRunning ? "Stop timer" : "Start timer") {
                      store.send(.toggleTimerButtonTapped)
                    }
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
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

