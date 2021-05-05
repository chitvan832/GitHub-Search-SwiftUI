//
//  AppEnvironment.swift
//  GithubSearch
//
//  Created by Chitvan Saxena on 06/05/21.
//

import Foundation

struct AppEnvironment {
    
    let decoder = JSONDecoder()
    
    var gitHubService: GitHubService {
        GitHubServiceLive(session: .shared, decoder: decoder)
    }
}
