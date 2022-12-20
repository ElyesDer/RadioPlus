//
//  EdgeWrapper.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import Foundation

struct EdgeWrapper<T: Codable>: Codable {
    let edges: [EdgeContent<T>]?
}

struct EdgeContent<T: Codable>: Codable {
    let cursor: String?
    let node: T?
}
