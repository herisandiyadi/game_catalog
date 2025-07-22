//
//  FavoriteModelMapper.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 22/07/25.
//

import Foundation

final class FavoriteModelMapper {
    static func mapFavoriteModelToEntity(_ favorite: FavoriteModel) -> FavoriteEntity {
        return FavoriteEntity(
            gameId: favorite.gameId,
            name: favorite.name,
            image: favorite.image,
            rating: favorite.rating,
            releaseDate: favorite.releaseDate,
            platforms: favorite.platforms,
            ratingCount: favorite.ratingCount
        )
    }
  
  static func mapFavoriteEntityToModel(_ entity: FavoriteEntity) -> FavoriteModel {
        let model = FavoriteModel()
        model.gameId = entity.gameId
        model.name = entity.name
        model.image = entity.image
        model.rating = entity.rating
        model.releaseDate = entity.releaseDate
        model.platforms = entity.platforms
        model.ratingCount = entity.ratingCount
        return model
    }
  
  static func mapModelToEntity(_ favorite: [FavoriteModel]) -> [FavoriteEntity] {
    return favorite.map { fav in
      FavoriteEntity(gameId: fav.gameId, name: fav.name, image: fav.image, rating: fav.rating, releaseDate: fav.releaseDate, platforms: fav.platforms, ratingCount: fav.ratingCount)
    }
    
  }
  
  static func mapEntitiesToModels(_ entities: [FavoriteEntity]) -> [FavoriteModel] {
         return entities.map { mapFavoriteEntityToModel($0) }
     }
}
