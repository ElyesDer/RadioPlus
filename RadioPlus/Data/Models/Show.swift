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

typealias Shows = [Show]

// MARK: - Show
struct Show: Codable, Identifiable {
    let id, title: String?
    let standFirst: String?
    let url: String?
    let diffusion: Diffusion?
    let diffusionsConnection: EdgeWrapper<Diffusion>?
}

// MARK: - DiffusionNode
struct DiffusionNode: Codable {
    let title: String?
    let url: String?
}

// MARK: - ShowsResponse
struct ShowsResponse: Codable {
    let shows: EdgeWrapper<Show>
}
