//
//  ServiceProvider.swift
//  GithubSearch
//
//  Created by Chitvan Saxena on 06/05/21.
//

import Foundation

protocol ServiceProvider {}

extension ServiceProvider {
    
    func validateResponse(for data: Data, for response: URLResponse) throws {
        let httpURLResponse = response as? HTTPURLResponse
        guard let statusCode = httpURLResponse?.statusCode else {
            throw NetworkError.unknownStatusCode
        }
        switch statusCode {
        case 200, 201:
            break
        case 202...500:
            throw NetworkError.unknownErrorOccurred
        default:
            throw NetworkError.unknownStatusCode
        }
    }
}
