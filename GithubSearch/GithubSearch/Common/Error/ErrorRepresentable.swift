//
//  ErrorRepresentable.swift
//  GithubSearch
//
//  Created by Chitvan Saxena on 06/05/21.
//

import Foundation

protocol ErrorRepresentable: Error {
    
    var title: String { get }
    var description: String { get }
}
