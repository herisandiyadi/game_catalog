//
//  ProductEntity.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 16/07/25.
//

import Foundation

struct ProductEntity: Identifiable {
  let id: Int
  let slug, name, released: String
  let tba: Bool
  let backgroundImage: String
  let rating: Double
  let ratingTop, ratingsCount, reviewsTextCount, added: Int
  let updated: String
  let userGame: String?
  let reviewsCount: Int
  let saturatedColor, dominantColor: String
  let parentPlatforms: [ParentPlatformEntity]
  let genres: [GenreEntity]
  let clip: String?
}
