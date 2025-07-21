//
//  SearchInteractor.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 21/07/25.
//

import Foundation

protocol SearchUsecase {
  func searchProduct(q: String, completion: @escaping (Result<[SearchResultEntity], Error>) -> Void )
}

class SearchInteractor: SearchUsecase {
  private let productRepository: ProductRepositoryProtocol

  init(productRepository: ProductRepositoryProtocol) {
    self.productRepository = productRepository
  }
  
  func searchProduct(q: String, completion: @escaping (Result<[SearchResultEntity], any Error>) -> Void) {
    productRepository.searchProduct(q: q, completion:  { results in
      completion(results)
    })
  }
}
