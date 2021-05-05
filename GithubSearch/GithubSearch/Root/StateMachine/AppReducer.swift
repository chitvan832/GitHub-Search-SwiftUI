//
//  AppReducer.swift
//  GithubSearch
//
//  Created by Chitvan Saxena on 06/05/21.
//

import Combine

let appReducer: Reducer<AppState, AppAction, AppEnvironment> = Reducer { state, action, environment in
    
    switch action {
    case .searchRepoView(.shouldStartSearch(let query)):
        state.shouldShowLoader = true
        state.repoSearchViewState.currentSearchQuery = query
        state.repoSearchViewState.currentPage = 0
        
        return environment.gitHubService
            .fetch(matching: query, page: state.repoSearchViewState.currentPage)
            .map({ AppAction.searchRepoView(.didReceiveSearchResponse($0)) })
            .catch{Just(AppAction.errorOccurred($0))}
            .eraseToAnyPublisher()
        
    case .searchRepoView(.didReceiveSearchResponse(let response)):
        state.repoSearchViewState.currentSearchResults = response.items
        state.shouldShowLoader = false
    case .errorOccurred(let error):
        state.error = error
    }
    return Empty(completeImmediately: true).eraseToAnyPublisher()
}
