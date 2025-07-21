//
//  DetailProductModel.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 07/07/25.
//

import Foundation

struct DetailProductModel: Decodable {
    let id: Int
    let slug, name, nameOriginal, description: String
    let released: String?
    let tba: Bool
    let updated: String
    let backgroundImage, backgroundImageAdditional: String
    let website: String
    let rating: Double
    let ratingsCount, reviewsCount: Int
    let saturatedColor, dominantColor: String
    let parentPlatforms: [ParentPlatform]
    let clip: String?
    let descriptionRaw: String

    enum CodingKeys: String, CodingKey {
        case id, slug, name
        case nameOriginal = "name_original"
        case description, released, tba, updated
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case website, rating
        case ratingsCount = "ratings_count"
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case parentPlatforms = "parent_platforms"
        case clip
        case descriptionRaw = "description_raw"
    }
}
