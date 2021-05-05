//
//  Reducer.swift
//  GithubSearch
//
//  Created by Chitvan Saxena on 06/05/21.
//

import Combine

struct Reducer<State, Action, Environment> {
    
    let reduce: (inout State, Action, Environment) -> AnyPublisher<Action, Never>
    
    func callAsFunction(
        _ state: inout State,
        _ action: Action,
        _ environment: Environment
    ) -> AnyPublisher<Action, Never> {
        reduce(&state, action, environment)
    }
}
