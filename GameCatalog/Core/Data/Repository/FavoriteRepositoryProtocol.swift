//
//  FavoriteRepositoryProtocol.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 22/07/25.
//

import Foundation
import RealmSwift
import Combine

protocol FavoriteRepositoryProtocol {
  func getFavoritesPublisher() -> AnyPublisher<[FavoriteEntity], Never>
  func isFavoritePublisher(gameId: Int) -> AnyPublisher<Bool, Never>
  func addFavorite(favoriteEntity: FavoriteEntity ,completion: @escaping (Result<Bool, Error>) -> Void)
  func removeFavorite(gameId: Int, completion: @escaping (Result<Bool, Error>) -> Void)
}
