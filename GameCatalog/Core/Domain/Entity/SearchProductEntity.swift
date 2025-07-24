//
//  SearchProductEntity.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 21/07/25.
//

import Foundation

struct SearchProductEntity {
  let count: Int
  let next: String
  let previous: String?
  let results: [SearchResultEntity]
  let userPlatforms: Bool?
}

struct SearchResultEntity: Identifiable {
  let slug, name: String
  let playtime: Int
  let platforms: [ParentPlatformEntity]
  let released: String?
  let tba: Bool
  let backgroundImage: String?
  let rating: Double
  let updated: String
  let id: Int
  let score: String?
  let clip: String?
  let reviewsCount, ratingsCount: Int
  let saturatedColor, dominantColor: String
  let parentPlatforms: [ParentPlatformEntity]
}
