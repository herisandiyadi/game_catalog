//
//  ProductModelMapper.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 16/07/25.
//

import Foundation

final class ProductModelMapper {
  
  static func mapProductResponsetoEntity(_ product: [ResultProduct]) -> [ProductEntity] {
    return product.map { prod in
      ProductEntity(id: prod.id, slug: prod.slug, name: prod.name, released: prod.released, tba: prod.tba, backgroundImage: prod.backgroundImage, rating: prod.rating, ratingTop: prod.ratingTop, ratingsCount: prod.ratingsCount, reviewsTextCount: prod.reviewsTextCount, added: prod.added, updated: prod.updated, userGame: prod.userGame, reviewsCount: prod.reviewsCount, saturatedColor: prod.saturatedColor, dominantColor: prod.dominantColor, parentPlatforms: parentPlatformModeltoEntity(prod.parentPlatforms), genres: genretoEntity(prod.genres), clip: prod.clip)
    }
  }
  
  static func parentPlatformModeltoEntity(_ parentPlatform: [ParentPlatform]) -> [ParentPlatformEntity] {
    return parentPlatform.map { platform in
      ParentPlatformEntity(platform: platformToEntity(platform.platform))
    }
  }
  
  static func platformToEntity(_ platform: Platform) -> PlatformEntity {
    return PlatformEntity(id: platform.id, name: platform.name, slug: platform.slug)
  }
  
  static func genretoEntity(_ genre: [Genre]) -> [GenreEntity] {
    return genre.map { genre in
      GenreEntity(id: genre.id, name: genre.name, slug: genre.slug, gamesCount: genre.gamesCount, imageBackground: genre.imageBackground)
    }
  }
}
