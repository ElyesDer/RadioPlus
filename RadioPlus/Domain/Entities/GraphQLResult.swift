//
//  GraphQLResult.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 19/12/2022.
//

import Foundation

// source: https://swiftstudent.com/2020-10-09-graphql-networking-using-urlsession/
struct GraphQLResult<T: Decodable>: Decodable {
    let data: T?
    let errors: [Error]?
    
    // MARK: - Error
    struct Error: Codable {
        let message: String?
        let locations: [Location]?
        let extensions: Extensions?
    }

    // MARK: - Extensions
    struct Extensions: Codable {
        let code: String
    }

    // MARK: - Location
    struct Location: Codable {
        let line, column: Int
    }
}
