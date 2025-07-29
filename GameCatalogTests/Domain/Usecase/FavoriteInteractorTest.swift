//
//  FavoriteInteractorTest.swift
//  GameCatalogTests
//
//  Created by Heri Sandiyadi on 28/07/25.
//

import XCTest
import Combine
@testable import GameCatalog

class FavoriteInteractorTest: XCTestCase {
    var interactor: FavoriteInteractor!
    var mockRepository: MockFavoriteRepository!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockRepository = MockFavoriteRepository()
        interactor = FavoriteInteractor(favoriteRepository: mockRepository)
        cancellables = []
    }

    override func tearDown() {
        interactor = nil
        mockRepository = nil
        cancellables = nil
        super.tearDown()
    }

    func testGetFavoritesPublisher() {
        let expectation = self.expectation(description: "Get favorites publisher emits values")
        interactor.getFavoritePublisher()
            .sink { favorites in
                XCTAssertEqual(favorites.count, 1)
                XCTAssertEqual(favorites.first?.name, "Grand Theft Auto V")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1.0)
    }

    func testIsFavoritePublisherTrue() {
        let expectation = self.expectation(description: "Is favorite publisher emits true")
        interactor.isFavoritePublisher(gameId: 1)
            .sink { isFav in
                XCTAssertTrue(isFav)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1.0)
    }

    func testIsFavoritePublisherFalse() {
        let expectation = self.expectation(description: "Is favorite publisher emits false")
        interactor.isFavoritePublisher(gameId: 999)
            .sink { isFav in
                XCTAssertFalse(isFav)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1.0)
    }

    func testAddFavoriteSuccess() {
        let expectation = self.expectation(description: "Add favorite success")
        let newFavorite = FavoriteEntity(
            gameId: 2,
            name: "Red Dead Redemption 2",
            image: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg",
            rating: 4.8,
            releaseDate: "2018-10-26",
            platforms: "PC, PlayStation, Xbox",
            ratingCount: 9000
        )
        interactor.addFavorite(favoriteEntity: newFavorite) { result in
            switch result {
            case .success(let success):
                XCTAssertTrue(success)
                XCTAssertEqual(self.mockRepository.mockFavorites.count, 2)
            case .failure(let error):
                XCTFail("Expected success, got error \(error)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testAddFavoriteFailure() {
        let expectation = self.expectation(description: "Add favorite failure")
        mockRepository.shouldReturnError = true
        let newFavorite = FavoriteEntity(
            gameId: 3,
            name: "Cyberpunk 2077",
            image: "https://media.rawg.io/media/games/ae1/ae1518c3b6b7b1b1b1b1b1b1b1b1b1b1.jpg",
            rating: 4.0,
            releaseDate: "2020-12-10",
            platforms: "PC, PlayStation, Xbox",
            ratingCount: 5000
        )
        interactor.addFavorite(favoriteEntity: newFavorite) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testRemoveFavoriteSuccess() {
        let expectation = self.expectation(description: "Remove favorite success")
        interactor.removeFavorite(gameId: 1) { result in
            switch result {
            case .success(let success):
                XCTAssertTrue(success)
                XCTAssertEqual(self.mockRepository.mockFavorites.count, 0)
            case .failure(let error):
                XCTFail("Expected success, got error \(error)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testRemoveFavoriteFailure() {
        let expectation = self.expectation(description: "Remove favorite failure")
        mockRepository.shouldReturnError = true
        interactor.removeFavorite(gameId: 1) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
