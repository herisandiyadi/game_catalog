//
//  MockFavoriteRepository.swift
//  GameCatalogTests
//
//  Created by Heri Sandiyadi on 28/07/25.
//

import Foundation
import Combine
@testable import GameCatalog

class MockFavoriteRepository: FavoriteRepositoryProtocol {
    var shouldReturnError = false
    var mockFavorites: [FavoriteEntity] = [
        FavoriteEntity(
            gameId: 1,
            name: "Grand Theft Auto V",
            image: "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg",
            rating: 4.47,
            releaseDate: "2013-09-17",
            platforms: "PC, PlayStation, Xbox",
            ratingCount: 7163
        )
    ]
    private var favoritesSubject = CurrentValueSubject<[FavoriteEntity], Never>([])
    private var isFavoriteSubject = CurrentValueSubject<Bool, Never>(false)

    func getFavoritesPublisher() -> AnyPublisher<[FavoriteEntity], Never> {
        favoritesSubject.value = mockFavorites
        return favoritesSubject.eraseToAnyPublisher()
    }

    func isFavoritePublisher(gameId: Int) -> AnyPublisher<Bool, Never> {
        let isFav = mockFavorites.contains(where: { $0.gameId == gameId })
        isFavoriteSubject.value = isFav
        return isFavoriteSubject.eraseToAnyPublisher()
    }

    func addFavorite(favoriteEntity: FavoriteEntity, completion: @escaping (Result<Bool, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "TestError", code: 1, userInfo: nil)))
        } else {
            mockFavorites.append(favoriteEntity)
            favoritesSubject.value = mockFavorites
            completion(.success(true))
        }
    }

    func removeFavorite(gameId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "TestError", code: 2, userInfo: nil)))
        } else {
            mockFavorites.removeAll(where: { $0.gameId == gameId })
            favoritesSubject.value = mockFavorites
            completion(.success(true))
        }
    }
}
