//
//  SearchResponse.swift
//  GithubSearch
//
//  Created by Chitvan Saxena on 06/05/21.
//

import Foundation

//MARK: - SearchResponse
struct SearchResponse: Decodable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Repository]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

// MARK: - Repository
struct Repository: Decodable, Identifiable {
    let id: Int
    let fullName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
    }
}
