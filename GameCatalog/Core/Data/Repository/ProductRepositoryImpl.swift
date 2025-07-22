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
        completion(.success(entities))
      case .failure(let failure):
        completion(.failure(failure))
      }
      
    }
  }
  
  func detailProduct(id: Int, completion: @escaping (Result<DetailProductEntity, any Error>) -> Void) {
    productService.fetchProductDetail(id: id) { detailResult in
      switch detailResult {
      case .success(let success):
        let entities = self.mapper.detailProductToEntity(success)
        completion(.success(entities))
      case .failure(let failure):
        completion(.failure(failure))
      }
    }
  }
  
  func searchProduct(q: String, completion: @escaping (Result<[SearchResultEntity], any Error>) -> Void) {
    productService.searchProduct(q: q) { searchResult in
      switch searchResult {
      case .success(let success):
        let entities = self.mapper.searchResultToEntity(success)
        completion(.success(entities))
      case .failure(let failure):
        completion(.failure(failure))
      }
      
    }
  }
}
