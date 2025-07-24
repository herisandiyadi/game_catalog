//
//  HomeInteractor.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 17/07/25.
//

import Foundation

protocol HomeUsecase {
  func getProductAll(completion: @escaping (Result<[ProductEntity], Error>) -> Void )
}

class HomeInteractor: HomeUsecase {
  private let productRepository: ProductRepositoryProtocol

  init(productRepository: ProductRepositoryProtocol) {
    self.productRepository = productRepository
  }
  
  func getProductAll(completion: @escaping (Result<[ProductEntity], any Error>) -> Void) {
    productRepository.getProducts { result in
      completion(result)
      
    }
  }
  
}
