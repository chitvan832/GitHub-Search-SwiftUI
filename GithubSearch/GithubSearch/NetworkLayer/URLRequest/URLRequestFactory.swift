//
//  URLRequestFactory.swift
//  GithubSearch
//
//  Created by Chitvan Saxena on 06/05/21.
//

import Foundation

struct URLRequestFactory {
    
    static func generateRequest(for request: RequestType,
                                with additionalData: AdditionalData) -> URLRequest? {
        var urlComponents = URLComponents(string: request.baseURL + request.endPoint)
        var bodyData: Data?
        switch additionalData {
        case .queryParameters(let parameters):
            var queryItems: [URLQueryItem] = []
            for eachQueryParam in parameters {
                queryItems.append(URLQueryItem(name: eachQueryParam.key,
                                               value: eachQueryParam.value))
            }
            urlComponents?.percentEncodedQueryItems = queryItems
        case .body(let data):
            bodyData = data
        }
        guard let url = urlComponents?.url else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.type.rawValue
        if let data = bodyData {
            urlRequest.httpBody = data
        }
        return urlRequest
    }
}

extension URLRequestFactory {
    
    enum RequestType {
        
        case searchRepo
        
        
        var baseURL: String {
            "https://api.github.com"
        }
        
        var type: HTTPMethod {
            switch self {
            case .searchRepo:
                return .get
            }
        }
        
        var endPoint: String {
            switch self {
            case .searchRepo:
                return "/search/repositories"
            }
        }
    }
    
    enum AdditionalData {
        
        case queryParameters([String: String])
        case body(Data)
    }
}
