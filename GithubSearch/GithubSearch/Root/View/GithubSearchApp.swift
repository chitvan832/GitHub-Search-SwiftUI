//
//  GithubSearchApp.swift
//  GithubSearch
//
//  Created by Chitvan Saxena on 06/05/21.
//

import SwiftUI

@main
struct GithubSearchApp: App {
    
    private let environment: AppEnvironment
    private let store: AppStore
    
    init() {
        environment = AppEnvironment()
        store = AppStore(
            initialState: AppState(),
            reducer: appReducer,
            environment: environment
        )
    }
    
    var body: some Scene {
        WindowGroup {
            RepositorySearchView()
                .environmentObject(store)
        }
    }
}
