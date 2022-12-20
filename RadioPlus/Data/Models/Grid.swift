//
//  Grid.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 19/12/2022.
//

import Foundation

struct GridQuery: Codable {
    let start: Int32
    let end: Int32
    let station: Stations
}

typealias Grids = [Grid]

// MARK: - GridResponse
struct GridResponse: Codable {
    let grid: [Grid]
}

// MARK: - Grid
struct Grid: Codable {
    let id: String?
    let title: String?
    let diffusion: Diffusion?
}
