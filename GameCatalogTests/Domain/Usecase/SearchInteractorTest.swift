//
//  SearchInteractorTest.swift
//  GameCatalogTests
//
//  Created by Heri Sandiyadi on 28/07/25.
//

import XCTest
@testable import GameCatalog

class SearchInteractorTest: XCTestCase {
    var interactor: SearchInteractor!
    var mockRepository: MockProductRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockProductRepository()
        interactor = SearchInteractor(productRepository: mockRepository)
    }

    override func tearDown() {
        interactor = nil
        mockRepository = nil
        super.tearDown()
    }

    func testSearchProductSuccess() {
        let expectation = self.expectation(description: "Search product success")
        interactor.searchProduct(q: "gta") { result in
            switch result {
            case .success(let results):
                XCTAssertEqual(results.count, 1)
                let first = results.first!
                XCTAssertEqual(first.name, "Grand Theft Auto V")
                XCTAssertEqual(first.slug, "grand-theft-auto-v")
                XCTAssertEqual(first.rating, 4.47)
                XCTAssertEqual(first.parentPlatforms.count, 3)
            case .failure(let error):
                XCTFail("Expected success, got error \(error)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testSearchProductFailure() {
        let expectation = self.expectation(description: "Search product failure")
        mockRepository.shouldReturnError = true
        interactor.searchProduct(q: "gta") { result in
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
