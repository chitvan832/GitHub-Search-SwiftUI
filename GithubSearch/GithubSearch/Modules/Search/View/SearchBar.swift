//
//  SearchBar.swift
//  GithubSearch
//
//  Created by Chitvan Saxena on 06/05/21.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText: String
    let onCommit: () -> Void
    @State private var isEditing = false
    
    private let horizontalPadding: CGFloat = 25.0
    private let cornerRadius: CGFloat = 8
    private let cancelButtonTrailingPadding: CGFloat = 10
    
    var body: some View {
        HStack {
            TextField("Search...",
                      text: $searchText,
                      onEditingChanged: {_ in }) {
                isEditing = false
                onCommit()
            }
            .padding(7)
            .padding(.horizontal, horizontalPadding)
            .background(Color(.systemGray6))
            .cornerRadius(cornerRadius)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                    
                    if isEditing {
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                    }
                }
            )
            .padding(.horizontal, 10)
            .onTapGesture {
                self.isEditing = true
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""), onCommit: {})
    }
}
