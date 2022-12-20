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

// MARK: - DataClass
struct LiveResponse: Codable {
    let live: Live?
}

// MARK: - Live
struct Live: Codable {
    let show: Show?
    let program, song: String?
}
