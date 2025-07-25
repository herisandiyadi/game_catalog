//
//  FavoriteInteractor.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 22/07/25.
//

import Foundation
import RealmSwift
import Combine


protocol FavoriteUsecase {
  func getFavoritePublisher() -> AnyPublisher<[FavoriteEntity], Never>
  func isFavoritePublisher(gameId: Int) -> AnyPublisher<Bool, Never>
  func addFavorite(favoriteEntity: FavoriteEntity ,completion: @escaping (Result<Bool, Error>) -> Void)
  func removeFavorite(gameId: Int, completion: @escaping (Result<Bool, Error>) -> Void)
}

class FavoriteInteractor: FavoriteUsecase {
  private let favoriteRepository: FavoriteRepositoryProtocol
  
  init(favoriteRepository: FavoriteRepositoryProtocol) {
    self.favoriteRepository = favoriteRepository
  }
  
  func getFavoritePublisher() -> AnyPublisher<[FavoriteEntity], Never> {
    favoriteRepository.getFavoritesPublisher()
           .replaceError(with: [])
           .eraseToAnyPublisher()
  }
  
  func isFavoritePublisher(gameId: Int) -> AnyPublisher<Bool, Never> {
    favoriteRepository.isFavoritePublisher(gameId: gameId)
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
}



