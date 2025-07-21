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
  
  static func detailProductToEntity(_ detailProduct: DetailProductModel) -> DetailProductEntity {
    return DetailProductEntity(id: detailProduct.id, slug: detailProduct.slug, name: detailProduct.name, nameOriginal: detailProduct.nameOriginal, description: detailProduct.description, released: detailProduct.released, tba: detailProduct.tba, updated: detailProduct.updated, backgroundImage: detailProduct.backgroundImage, backgroundImageAdditional: detailProduct.backgroundImageAdditional, website: detailProduct.website, rating: detailProduct.rating, ratingsCount: detailProduct.ratingsCount, reviewsCount: detailProduct.reviewsCount, saturatedColor: detailProduct.saturatedColor, dominantColor: detailProduct.dominantColor, parentPlatforms:parentPlatformModeltoEntity(detailProduct.parentPlatforms), clip: detailProduct.clip, descriptionRaw: detailProduct.descriptionRaw)
  }
  
  static func searchProductToEntity(_ searchProduct: SearchProductModel) -> SearchProductEntity {
    return SearchProductEntity(count: searchProduct.count, next: searchProduct.next, previous: searchProduct.previous, results: searchResultToEntity(searchProduct.results), userPlatforms: searchProduct.userPlatforms)
  }
  
  static func searchResultToEntity(_ searchResults: [SearchResult]) -> [SearchResultEntity] {
    return searchResults.map { searchResult in
      SearchResultEntity(slug: searchResult.slug, name: searchResult.name, playtime: searchResult.playtime, platforms: parentPlatformModeltoEntity(searchResult.parentPlatforms), released: searchResult.released, tba: searchResult.tba, backgroundImage: searchResult.backgroundImage, rating: searchResult.rating, updated: searchResult.updated, id: searchResult.id, score: searchResult.score, clip: searchResult.clip, reviewsCount: searchResult.reviewsCount, ratingsCount: searchResult.ratingsCount, saturatedColor: searchResult.saturatedColor, dominantColor: searchResult.dominantColor, parentPlatforms: parentPlatformModeltoEntity(searchResult.parentPlatforms))
    }
    }
}
