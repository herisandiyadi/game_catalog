//
//  DetailProductEntity.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 21/07/25.
//

import Foundation

struct DetailProductEntity: Identifiable {
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
  let parentPlatforms: [ParentPlatformEntity]
  let clip: String?
  let descriptionRaw: String
}
