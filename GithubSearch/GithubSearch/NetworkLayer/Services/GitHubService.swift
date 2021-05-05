//
//  GitHubService.swift
//  GithubSearch
//
//  Created by Chitvan Saxena on 06/05/21.
//

import Combine
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

protocol GitHubService: ServiceProvider {
    func fetch(matching query: String, page: Int) -> AnyPublisher<SearchResponse, NetworkError>
}

struct GitHubServiceLive: GitHubService {
    
    let session: URLSession
    let decoder: JSONDecoder
    
    func fetch(matching query: String, page: Int) -> AnyPublisher<SearchResponse, NetworkError> {
        let parameters: [String: String] = ["q": query, "page": "\(page)", "per_page": "100"] //TODO: Change to less number and add pagination
        guard let request = URLRequestFactory.generateRequest(for: .searchRepo, with: .queryParameters(parameters)) else {
            return Fail<SearchResponse, NetworkError>(error: .badRequestBody)
                .eraseToAnyPublisher()
        }
        return session
            .dataTaskPublisher(for: request)
            .tryMap { response -> Data in
                try self.validateResponse(for: response.data, for: response.response)
                return response.data
            }
            .decode(type: SearchResponse.self, decoder: decoder)
            .mapError({ error -> NetworkError in
                if let error = error as? NetworkError {
                    return error
                } else {
                    return NetworkError.responseDecodingFailed
                }
            })
            .eraseToAnyPublisher()
    }
}

/*Note: We can create a mock service as well
 struct GitHubServiceMock: GitHubService {}
 */


//TODO: Move to separate file

protocol ErrorRepresentable: Error {
    
    var title: String { get }
    var description: String { get }
}
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
