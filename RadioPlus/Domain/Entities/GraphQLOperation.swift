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
}
