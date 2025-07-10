//
//  SearchProductModel.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 06/05/25.
//

import Foundation

struct SearchProductModel: Decodable {
    let count: Int
    let next: String
    let previous: JSONNull?
    let results: [SearchResult]
    let userPlatforms: Bool?

    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
        case userPlatforms = "user_platforms"
    }
}

struct SearchResult: Decodable {
    let slug, name: String
    let playtime: Int
    let platforms: [ParentPlatformElement]
    let released: String
    let tba: Bool
    let backgroundImage: String?
    let rating: Double
    let updated: String
    let id: Int
    let score: String?
    let clip: JSONNull?
    let reviewsCount, ratingsCount: Int
    let saturatedColor, dominantColor: String
    let parentPlatforms: [ParentPlatform]

    enum CodingKeys: String, CodingKey {
        case slug, name, playtime, platforms, released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingsCount = "ratings_count"
        case updated, id, score, clip
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case parentPlatforms = "parent_platforms"
    }
}

struct ParentPlatformElement: Decodable {
    let platform: ParentPlatformPlatform
}

struct ParentPlatformPlatform: Decodable {
    let id: Int
    let name, slug: String
}
