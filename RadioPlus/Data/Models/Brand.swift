//
//  Brand.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import Foundation

struct BrandQuery: Codable {
    
}

// MARK: - BrandResponse
struct BrandResponse: Codable {
    let brands: [Brand]
}

typealias Brands = [Brand]
// MARK: - Brand
struct Brand: Codable, Identifiable {
    let id, title: String?
    let baseline: String?
    let brandDescription: String?
    let websiteURL: String?
    let liveStream: String?
    let localRadios, webRadios: [Radio]?

    enum CodingKeys: String, CodingKey {
        case id, title, baseline
        case brandDescription = "description"
        case websiteURL = "websiteUrl"
        case liveStream, localRadios, webRadios
    }
}

typealias Radios = [Radio]
// MARK: - Radio
struct Radio: Codable, Identifiable {
    let id, title, radioDescription: String?
    let liveStream: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case radioDescription = "description"
        case liveStream
    }
}
