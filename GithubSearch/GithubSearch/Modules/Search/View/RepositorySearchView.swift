//
//  RepositorySearchView.swift
//  GithubSearch
//
//  Created by Chitvan Saxena on 06/05/21.
//

import SwiftUI

struct RepositorySearchView: View {
    
    @EnvironmentObject var store: AppStore
    @State var searchText: String = ""
    
    var body: some View {
        VStack {
            SearchBar(searchText: $searchText, onCommit: {
                store.send(.searchRepoView(.shouldStartSearch(searchText)))
            })
            List(store.state.repoSearchViewState.currentSearchResults) { repository in
                SearchResultsRow(repository: repository)
            }
        }
    }
}

struct RepositoriesSearchView_Previews: PreviewProvider {
    static var previews: some View {
        RepositorySearchView()
    }
}
