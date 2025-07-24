//
//  FavoriteRepositoryProtocol.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 22/07/25.
//

import Foundation
import RealmSwift

protocol FavoriteRepositoryProtocol {
  func observeFavorites(changeHandler: @escaping (Result<[FavoriteEntity], Error>) -> Void) -> NotificationToken?
  func addFavorite(favoriteEntity: FavoriteEntity ,completion: @escaping (Result<Bool, Error>) -> Void)
  func removeFavorite(gameId: Int, completion: @escaping (Result<Bool, Error>) -> Void)
  func isFavorite(gameId: Int) -> Bool
}
