//
//  GraphQLOperation.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 19/12/2022.
//

import Foundation

protocol GraphQLOperationProtocol<Input, Output>: Encodable, NetworkProvider {
    associatedtype Input: Encodable
    associatedtype Output: Decodable
    
    var input: Input { get }
    var operationString: String { get }
    
    func encode(to encoder: Encoder) throws
}

enum GraphQLOperationCodingKeys: String, CodingKey {
    case variables
    case query
}

extension GraphQLOperationProtocol {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: GraphQLOperationCodingKeys.self)
        try container.encode(input, forKey: .variables)
        try container.encode(operationString, forKey: .query)
    }
    
    public func buildURLRequest() throws -> URLRequest {
        guard let url = URL(string: self.endURL.rawValue) else { throw NetworkProviderError.urlBuilder }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(APIProvider.token, forHTTPHeaderField: "X-Token")
        urlRequest.setValue("application/json", forHTTPHeaderField:"Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField:"Accept")
        urlRequest.setValue("gzip, deflate, br", forHTTPHeaderField:"Accept-Encoding")
        
        urlRequest.httpBody = try JSONEncoder().encode(self)
        
        return urlRequest
    }
    
}
