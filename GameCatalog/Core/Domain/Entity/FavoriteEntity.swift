//
//  FavoriteEntity.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 22/07/25.
//

import Foundation

class FavoriteEntity: Identifiable, Equatable {
  var gameId: Int = 0
  var name: String = ""
  var image: String = ""
  var rating: Double = 0.0
  var releaseDate: String = ""
  var platforms: String = ""
  var ratingCount: Int = 0
  
  init(gameId: Int, name: String, image: String, rating: Double, releaseDate: String, platforms: String, ratingCount: Int) {
      self.gameId = gameId
      self.name = name
      self.image = image
      self.rating = rating
      self.releaseDate = releaseDate
      self.platforms = platforms
      self.ratingCount = ratingCount
  }
  
  static func == (lhs: FavoriteEntity, rhs: FavoriteEntity) -> Bool {
          return lhs.gameId == rhs.gameId &&
                 lhs.name == rhs.name &&
                 lhs.image == rhs.image &&
                 lhs.rating == rhs.rating &&
                 lhs.releaseDate == rhs.releaseDate &&
                 lhs.platforms == rhs.platforms &&
                 lhs.ratingCount == rhs.ratingCount
      }
}
