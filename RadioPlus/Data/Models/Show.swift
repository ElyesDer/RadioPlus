//
//  Show.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import Foundation

struct ShowQuery: Codable {
    let station: Stations
    let first: Int
}

// MARK: - Show
struct Show: Codable {
    let id, title: String?
    let diffusion: Diffusion?
}

// MARK: - ShowsResponse
struct ShowsResponse: Codable {
    let shows: EdgeWrapper<Show>
}
