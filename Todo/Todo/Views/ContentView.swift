//
//  ContentView.swift
//  Todo
//
//  Created by Oleh on 24.09.2025.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {
    let store: StoreOf<AppFeature>
  
  var body: some View {
    TabView {
      CounterView(store: store.scope(state: \.tab1, action: \.tab1))
        .tabItem {
          Text("Counter 1")
        }
      
      CounterView(store: store.scope(state: \.tab1, action: \.tab1))
        .tabItem {
          Text("Counter 2")
        }
    }
  }
}

struct CounterView: View {
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
    AppView(
        store: Store(initialState: AppFeature.State()) {
            AppFeature()
        }
    )
}

