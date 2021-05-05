//
//  NetworkError.swift
//  GithubSearch
//
//  Created by Chitvan Saxena on 06/05/21.
//

import Foundation

enum NetworkError: ErrorRepresentable {
    
    case badRequestBody
    case unknownStatusCode
    case unknownErrorOccurred
    case responseDecodingFailed
    
    var title: String {
        "Network Error"
    }
    
    var description: String {
        switch self {
        case .badRequestBody:
            return "Issue with request. Please provide valid data"
        case .unknownStatusCode:
            return "Found unknown status code"
        case .unknownErrorOccurred:
            return "An unknown error has occured"
        case .responseDecodingFailed:
            return "Response decoding failed"
        }
    }
}
