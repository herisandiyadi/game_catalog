// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let productModel = try? JSONDecoder().decode(ProductModel.self, from: jsonData)

import Foundation

struct ProductModel: Decodable {
    let count: Int
    let next: String
    let previous: JSONNull?
    let results: [Result]
}

struct Result: Decodable {
    let id: Int
    let slug, name, released: String
    let tba: Bool
    let backgroundImage: String
    let rating: Double
    let ratingTop, ratingsCount, reviewsTextCount, added: Int
    let updated: String
    let userGame: JSONNull?
    let reviewsCount: Int
    let saturatedColor, dominantColor: String
    let parentPlatforms: [ParentPlatform]
    let genres: [Genre]
    let clip: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, slug, name, released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added, updated
        case userGame = "user_game"
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case parentPlatforms = "parent_platforms"
        case genres, clip
    }
}

struct Genre: Decodable {
    let id: Int
    let name, slug: String
    let gamesCount: Int
    let imageBackground: String

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

struct ParentPlatform: Decodable {
    let platform: Platform
}

struct Platform: Decodable {
    let id: Int
    let name, slug: String
}

class JSONNull: Decodable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}
