//
//  DetailInteractor.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 21/07/25.
//

import Foundation

protocol DetailUsecase {
  func getDetailGame(id: Int, completion: @escaping (Result<DetailProductEntity, Error>) -> Void)
}

final class DetailInteractor: DetailUsecase {
 private let productRepository: ProductRepositoryProtocol
  
  init(productRepository: ProductRepositoryProtocol) {
    self.productRepository = productRepository
  }
  
  func getDetailGame(id: Int, completion: @escaping (Result<DetailProductEntity, any Error>) -> Void) {
    
    productRepository.detailProduct(id: id, completion: { detailResult in
      completion(detailResult)
    })
  }
  
}
