//
//  RepositoriesSearchAction.swift
//  GithubSearch
//
//  Created by Chitvan Saxena on 06/05/21.
//

import Foundation

enum RepositoriesSearchAction {
    
    case shouldStartSearch(String)
    case didReceiveSearchResponse(_ response: SearchResponse)
}
