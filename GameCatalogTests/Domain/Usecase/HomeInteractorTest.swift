//
//  HomeInteractorTest.swift
//  GameCatalogTests
//
//  Created by Heri Sandiyadi on 26/07/25.
//

import XCTest
import Foundation
@testable import GameCatalog


class HomeInteractorTests: XCTestCase {
    var interactor: HomeInteractor!
    var mockRepository: MockProductRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockProductRepository()
        interactor = HomeInteractor(productRepository: mockRepository)
    }
    
    override func tearDown() {
        interactor = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testGetProductAllSuccess() {
        let expectation = self.expectation(description: "Fetch products successfully")
        
        interactor.getProductAll { result in
            switch result {
            case .success(let products):
                XCTAssertEqual(products.count, 1)
                XCTAssertEqual(products.first?.name, "Grand Theft Auto V")
            case .failure(let error):
                XCTFail("Expected success, but got error \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetProductAllFailure() {
        let expectation = self.expectation(description: "Fetch products failed")
        mockRepository.shouldReturnError = true
        
        interactor.getProductAll { result in
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
