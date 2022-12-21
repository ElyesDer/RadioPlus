//
//  Live.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import Foundation

struct LiveQuery: Codable {
    let station: Stations
}

typealias Lives = [Live]

// MARK: - LiveResponse
struct LiveResponse: Codable {
    let live: Live?
}

// MARK: - Live
struct Live: Codable {
    let show: Show?
    let program: Program?
    let song: String?
}

// MARK: - Program
struct Program: Codable {
    let id: String?
    let diffusion: Diffusion?
}
