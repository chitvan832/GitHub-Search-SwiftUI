//
//  Store.swift
//  GithubSearch
//
//  Created by Chitvan Saxena on 06/05/21.
//

import Combine
import Foundation

final class Store<State, Action>: ObservableObject {
    
    @Published private(set) var state: State
    
    private let reduce: (inout State, Action) -> AnyPublisher<Action, Never>
    private var reducerSubscription: AnyCancellable?
    
    init<Environment>(
        initialState: State,
        reducer: Reducer<State, Action, Environment>,
        environment: Environment
    ) {
        self.state = initialState
        self.reduce = { state, action in
            reducer(&state, action, environment)
        }
    }
    
    func send(_ action: Action) {
        let effect = reduce(&state, action)
        
        reducerSubscription = effect
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] _ in
                self?.reducerSubscription = nil
            }, receiveValue: { [weak self] in
                self?.send($0)
            })
    }
}
