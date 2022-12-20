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

// MARK: - DataClass
struct GridResponse: Codable {
    let grid: [Grid]
}

// MARK: - Grid
struct Grid: Codable {
    let id: String?
    let title: String?
    let diffusion: Diffusion?
}

// MARK: - Diffusion
struct Diffusion: Codable {
    let id, title: String?
    let standFirst, url: String?
    let publishedDate: String?

    enum CodingKeys: String, CodingKey {
        case id, title, standFirst, url
        case publishedDate
    }
}
