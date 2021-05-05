//
//  SearchResultsRow.swift
//  GithubSearch
//
//  Created by Chitvan Saxena on 06/05/21.
//

import SwiftUI

extension RepositorySearchView {
    
    struct SearchResultsRow: View {
        
        let repository: Repository
        
        var body: some View {
            Text(repository.fullName)
        }
    }
}
