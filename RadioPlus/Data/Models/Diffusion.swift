//
//  Diffusion.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import Foundation

// MARK: - Diffusion
struct Diffusion: Codable {
    let id, title, standFirst: String?
    let url: String?
    let publishedDate: String?
    let podcastEpisode: PodcastEpisode?

    enum CodingKeys: String, CodingKey {
        case id, title, standFirst, url
        case publishedDate
        case podcastEpisode
    }
}

// MARK: - PodcastEpisode
struct PodcastEpisode: Codable {
    let id, title: String?
    let url: String?
    let created, duration: Int?
}
