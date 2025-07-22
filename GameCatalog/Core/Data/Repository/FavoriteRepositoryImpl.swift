//
//  FavoriteRepositoryImpl.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 22/07/25.
//

import Foundation
import RealmSwift

class FavoriteRepositoryImpl: FavoriteRepositoryProtocol {
  private let favoriteLocalDataSource: FavoriteLocalDataSource
  private let mapper: FavoriteModelMapper.Type
  
  init(favoriteLocalDataSource: FavoriteLocalDataSource, mapper: FavoriteModelMapper.Type = FavoriteModelMapper.self) {
    self.favoriteLocalDataSource = favoriteLocalDataSource
    self.mapper = mapper
  }
  
  func addFavorite(favoriteEntity: FavoriteEntity, completion: @escaping (Result<Bool, any Error>) -> Void) {
    let model = FavoriteModelMapper.mapFavoriteEntityToModel(favoriteEntity)
    
    favoriteLocalDataSource.addFavorite(model) { result in
      switch result {
      case .success(let success):
        completion(.success(success))
        
      case .failure(let failure):
        completion(.failure(failure))
      }
    }
  }
  
  
  
  func removeFavorite(gameId: Int, completion: @escaping (Result<Bool, any Error>) -> Void) {
    favoriteLocalDataSource.deleteFavorite(gameId: gameId) { result in
      switch result {
      case .success(let success):
        completion(.success(success))
      case .failure(let failure):
        completion(.failure(failure))
      }
    }
  }
  
  func isFavorite(gameId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
      let isFav = favoriteLocalDataSource.isFavorite(gameId: gameId)
      completion(.success(isFav))
  }
  
func observeFavorites(changeHandler: @escaping (Result<[FavoriteEntity], any Error>) -> Void) -> RealmSwift.NotificationToken? {
  return favoriteLocalDataSource.observeFavorites { results in
      switch results {
      case .success(let success):
        let entitites = self.mapper.mapModelToEntity(success)
        changeHandler(.success(entitites))
      case .failure(let failure):
        changeHandler(.failure(failure))
    }
  }
  }

}
