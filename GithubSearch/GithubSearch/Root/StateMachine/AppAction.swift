//
//  AppAction.swift
//  GithubSearch
//
//  Created by Chitvan Saxena on 06/05/21.
//

import Foundation

enum AppAction {
    
    case errorOccurred(_ error: ErrorRepresentable)
    case searchRepoView(_ action: RepositoriesSearchAction)
}
