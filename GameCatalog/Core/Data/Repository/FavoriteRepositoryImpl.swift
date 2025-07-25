//
//  FavoriteRepositoryImpl.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 22/07/25.
//

import Foundation
import RealmSwift
import Combine

class FavoriteRepositoryImpl: FavoriteRepositoryProtocol {
  private let favoriteLocalDataSource: FavoriteLocalDataSource
  private let mapper: FavoriteModelMapper.Type
  
  init(favoriteLocalDataSource: FavoriteLocalDataSource, mapper: FavoriteModelMapper.Type = FavoriteModelMapper.self) {
    self.favoriteLocalDataSource = favoriteLocalDataSource
    self.mapper = mapper
  }
  
  func getFavoritesPublisher() -> AnyPublisher<[FavoriteEntity], Never> {
    favoriteLocalDataSource.getFavoritePublisher().map { models in  models.map {self.mapper.mapFavoriteModelToEntity($0) } }.eraseToAnyPublisher()
  }
  
  func isFavoritePublisher(gameId: Int) -> AnyPublisher<Bool, Never> {
    favoriteLocalDataSource.isFavoritePublisher(gameId: gameId)
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
  
}
