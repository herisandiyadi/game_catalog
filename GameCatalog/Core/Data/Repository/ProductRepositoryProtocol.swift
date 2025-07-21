//
//  ProductRepositoryProtocol.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 16/07/25.
//

import Foundation

protocol ProductRepositoryProtocol {
  func getProducts(completion: @escaping (Result<[ProductEntity], Error>) -> Void)
  func detailProduct(id: Int, completion: @escaping (Result<DetailProductEntity, Error>) -> Void )
}
