//
//  AppState.swift
//  GithubSearch
//
//  Created by Chitvan Saxena on 06/05/21.
//

import Foundation

typealias AppStore = Store<AppState, AppAction>

struct AppState {
    
    var shouldShowLoader = false
    var repoSearchViewState = RepoSearchViewState()
    var error: ErrorRepresentable?
}

struct RepoSearchViewState {
    
    var currentSearchQuery = ""
    var currentPage = 0
    var currentSearchResults: [Repository] = []
}
