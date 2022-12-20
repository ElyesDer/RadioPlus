//
//  Requester.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 19/12/2022.
//

import Foundation
import Combine

protocol ResponseWrapper: Decodable { }

protocol HasDataServiceProviderProtocol {
    var dataServiceProvider: DataServiceProviderProtocol { get }
}
protocol DataServiceProviderProtocol {
    func performOperation<Input, Output>(_ operation: any GraphQLOperationProtocol<Input, Output>) async throws -> Output where Input: Decodable, Output: Decodable
}

class Requester: DataServiceProviderProtocol {
    
    enum ServiceError: Error {
        case badDataRequest
        case urlRequest
        case statusCodeError(Int)
        case responseError
        case unauthorized
        case unhandled
        case decodingError
    }
    
    func performOperation<Input, Output>(_ operation: any GraphQLOperationProtocol<Input, Output>) async throws -> Output where Input: Decodable, Output: Decodable {
        
        guard let urlRequest: URLRequest = try? operation.buildURLRequest() else {
            throw ServiceError.urlRequest
        }
        
        let sessionResponse = try await URLSession.shared.data(for: urlRequest)
        
        // handle errors
        guard let response = sessionResponse.1 as? HTTPURLResponse else {
            throw ServiceError.responseError
        }
        
        guard response.statusCode == 200 else {
            throw ServiceError.statusCodeError(response.statusCode)
        }
        
        guard let resultObject = try JSONDecoder().decode(GraphQLResult<Output>.self, from: sessionResponse.0).data else {
            throw ServiceError.decodingError
        }
        return resultObject
    }
}
