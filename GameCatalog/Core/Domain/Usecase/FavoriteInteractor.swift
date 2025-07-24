//
//  FavoriteInteractor.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 22/07/25.
//

import Foundation
import RealmSwift

protocol FavoriteUsecase {
  func observeFavorites(changeHandler: @escaping (Result<[FavoriteEntity], Error>) -> Void) -> NotificationToken?
  func addFavorite(favoriteEntity: FavoriteEntity ,completion: @escaping (Result<Bool, Error>) -> Void)
  func removeFavorite(gameId: Int, completion: @escaping (Result<Bool, Error>) -> Void)
  func isFavorite(gameId: Int) -> Bool
}

class FavoriteInteractor: FavoriteUsecase {
  private let favoriteRepository: FavoriteRepositoryProtocol
  
  init(favoriteRepository: FavoriteRepositoryProtocol) {
    self.favoriteRepository = favoriteRepository
  }
  
  func observeFavorites(changeHandler: @escaping (Result<[FavoriteEntity], any Error>) -> Void) -> RealmSwift.NotificationToken? {
    favoriteRepository.observeFavorites(changeHandler: changeHandler)
  }
  
  func addFavorite(favoriteEntity: FavoriteEntity, completion: @escaping (Result<Bool, any Error>) -> Void) {
    favoriteRepository.addFavorite(favoriteEntity: favoriteEntity, completion: { result in
      completion(result)
    })
  }
  
  func removeFavorite(gameId: Int, completion: @escaping (Result<Bool, any Error>) -> Void) {
    favoriteRepository.removeFavorite(gameId: gameId, completion:  { result in
        completion(result)
    })
  }
  
  func isFavorite(gameId: Int) -> Bool {
      favoriteRepository.isFavorite(gameId: gameId)
  }
}



