//
//  ProductRepositoryImpl.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 16/07/25.
//

import Foundation

class ProductRepositoryImpl: ProductRepositoryProtocol {
  private let productService: ProductServiceProtocol
  private let mapper: ProductModelMapper.Type
  
  init(productService: ProductServiceProtocol, mapper: ProductModelMapper.Type = ProductModelMapper.self) {
    self.productService = productService
    self.mapper = mapper
  }
  
  func getProducts(completion: @escaping (Result<[ProductEntity], any Error>) -> Void) {
    productService.fetchProducts { result in
      
      switch result {
      case .success(let success):
        let entities = self.mapper.mapProductResponsetoEntity(success)
        print("DATA REPO \(entities)")

        completion(.success(entities))
      case .failure(let failure):
        completion(.failure(failure))
      }
      
    }
  }
  
}
