//
//  DetailInteractorTest.swift
//  GameCatalogTests
//
//  Created by Heri Sandiyadi on 28/07/25.
//

import XCTest
@testable import GameCatalog

class DetailInteractorTest: XCTestCase {
    var interactor: DetailInteractor!
    var mockRepository: MockProductRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockProductRepository()
        interactor = DetailInteractor(productRepository: mockRepository)
    }

    override func tearDown() {
        interactor = nil
        mockRepository = nil
        super.tearDown()
    }

    func testGetDetailGameSuccess() {
        let expectation = self.expectation(description: "Fetch detail product successfully")
        let testId = 3498

        interactor.getDetailGame(id: testId) { result in
            switch result {
            case .success(let detail):
                XCTAssertEqual(detail.id, testId)
                XCTAssertEqual(detail.name, "Grand Theft Auto V")
                XCTAssertEqual(detail.slug, "grand-theft-auto-v")
                XCTAssertEqual(detail.rating, 4.47)
                XCTAssertEqual(detail.parentPlatforms.count, 3)
            case .failure(let error):
                XCTFail("Expected success, but got error \(error)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testGetDetailGameFailure() {
        let expectation = self.expectation(description: "Fetch detail product failed")
        mockRepository.shouldReturnError = true

        interactor.getDetailGame(id: 1) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                XCTAssertNotNil(error, "Error should not be nil")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
