//
//  APIProvider.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 19/12/2022.
//

import Foundation

enum NetworkProviderError: Error {
    case urlBuilder
    case urlRequest
}

public protocol NetworkProvider {
    var method: HTTPMethods { get }
    var endURL: APIProvider { get }
    
    func buildURLRequest() throws -> URLRequest
}

public enum APIProvider {
    
    public static let token: String = Bundle.main.infoDictionary?["API_KEY"] as? String ?? "NO_TOKEN"
    
    private var baseUrl: String {
//        "https://httpbin.org/post"
        "https://openapi.radiofrance.fr/v1/graphql"
    }
    
    case api
    
    var rawValue: String {
        switch self {
            case .api:
                return baseUrl // + "?x-token=84c107b0-22f0-4958-883d-381edaa54174"
        }
    }
}

public enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

public struct APIEndpoint: NetworkProvider {
    
    public var method: HTTPMethods
    public let endURL: APIProvider
    
    public init(method: HTTPMethods,
                endURL: APIProvider) {
        self.method = method
        self.endURL = endURL
    }
    
    public func buildURLRequest() throws -> URLRequest {
        guard let url = URL(string: self.endURL.rawValue) else { throw NetworkProviderError.urlBuilder }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(APIProvider.token, forHTTPHeaderField: "X-Token")
        
        return urlRequest
    }
}
