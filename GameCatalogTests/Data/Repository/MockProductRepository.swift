//
//  MockProductRepository.swift
//  GameCatalogTests
//
//  Created by Heri Sandiyadi on 26/07/25.
//

import Foundation

import XCTest
@testable import GameCatalog

class MockProductRepository: ProductRepositoryProtocol {
  func detailProduct(id: Int, completion: @escaping (Result<GameCatalog.DetailProductEntity, any Error>) -> Void) {
      if shouldReturnError {
          completion(.failure(NSError(domain: "TestError", code: 2, userInfo: nil)))
      } else {
          let mockDetail = DetailProductEntity(
              id: id,
              slug: "grand-theft-auto-v",
              name: "Grand Theft Auto V",
              nameOriginal: "Grand Theft Auto V",
              description: "Game open world populer.",
              released: "2013-09-17",
              tba: false,
              updated: "2025-07-27T14:47:51",
              backgroundImage: "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg",
              backgroundImageAdditional: "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg",
              website: "https://www.rockstargames.com/V/",
              rating: 4.47,
              ratingsCount: 7163,
              reviewsCount: 7279,
              saturatedColor: "0f0f0f",
              dominantColor: "0f0f0f",
              parentPlatforms: [
                  ParentPlatformEntity(platform: PlatformEntity(id: 1, name: "PC", slug: "pc")),
                  ParentPlatformEntity(platform: PlatformEntity(id: 2, name: "PlayStation", slug: "playstation")),
                  ParentPlatformEntity(platform: PlatformEntity(id: 3, name: "Xbox", slug: "xbox"))
              ],
              clip: nil,
              descriptionRaw: "Game open world populer dan sangat terkenal."
          )
          completion(.success(mockDetail))
      }
  }
  
  func searchProduct(q: String, completion: @escaping (Result<[GameCatalog.SearchResultEntity], any Error>) -> Void) {
      if shouldReturnError {
          completion(.failure(NSError(domain: "TestError", code: 3, userInfo: nil)))
      } else {
          let mockResults = [
              SearchResultEntity(
                  slug: "grand-theft-auto-v",
                  name: "Grand Theft Auto V",
                  playtime: 100,
                  platforms: [
                      ParentPlatformEntity(platform: PlatformEntity(id: 1, name: "PC", slug: "pc")),
                      ParentPlatformEntity(platform: PlatformEntity(id: 2, name: "PlayStation", slug: "playstation")),
                      ParentPlatformEntity(platform: PlatformEntity(id: 3, name: "Xbox", slug: "xbox"))
                  ],
                  released: "2013-09-17",
                  tba: false,
                  backgroundImage: "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg",
                  rating: 4.47,
                  updated: "2025-07-27T14:47:51",
                  id: 1,
                  score: nil,
                  clip: nil,
                  reviewsCount: 7279,
                  ratingsCount: 7163,
                  saturatedColor: "0f0f0f",
                  dominantColor: "0f0f0f",
                  parentPlatforms: [
                      ParentPlatformEntity(platform: PlatformEntity(id: 1, name: "PC", slug: "pc")),
                      ParentPlatformEntity(platform: PlatformEntity(id: 2, name: "PlayStation", slug: "playstation")),
                      ParentPlatformEntity(platform: PlatformEntity(id: 3, name: "Xbox", slug: "xbox"))
                  ]
              )
          ]
          completion(.success(mockResults))
      }
  }
  
    var shouldReturnError = false
    var mockProducts: [ProductEntity] = [
        ProductEntity(id: 3498, slug: "grand-theft-auto-v", name: "Grand Theft Auto V", released: "2013-09-17", tba: false, backgroundImage: "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg", rating: 4.47, ratingTop: 5, ratingsCount: 7163, reviewsTextCount: 67, added: 22143, updated: "2025-07-27T14:47:51", userGame: nil, reviewsCount: 7279, saturatedColor: "0f0f0f", dominantColor: "0f0f0f", parentPlatforms: [ParentPlatformEntity(platform: PlatformEntity(id: 1, name: "PC", slug: "pc")), ParentPlatformEntity(platform: PlatformEntity(id: 2, name: "PlayStation", slug: "playstation")), ParentPlatformEntity(platform: PlatformEntity(id: 3, name: "Xbox", slug: "xbox"))], genres: [GenreEntity(id: 4, name: "Action", slug: "action", gamesCount: 188571, imageBackground: "https://media.rawg.io/media/games/34b/34b1f1850a1c06fd971bc6ab3ac0ce0e.jpg")], clip: nil)
       
    ]
    
    func getProducts(completion: @escaping (Result<[ProductEntity], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "TestError", code: 1, userInfo: nil)))
        } else {
            completion(.success(mockProducts))
        }
    }
}
