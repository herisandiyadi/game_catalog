//
//  ProductServiceProtocol.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 15/07/25.
//

import Foundation
import Alamofire

protocol ProductServiceProtocol {
    func fetchProducts(completion: @escaping (Result<[ResultProduct], Error>) -> Void)
    func fetchProductDetail(id: Int, completion: @escaping (Result<DetailProductModel, Error>) -> Void )
    func searchProduct(q: String, completion: @escaping (Result<[SearchResult], Error>) -> Void)
}

class ProductService: ProductServiceProtocol {
    
    func searchProduct(q: String, completion: @escaping (Result<[SearchResult], any Error>) -> Void) {
      let url = Endpoints.Gets.search(query: q).path

        AF.request(url).validate().responseDecodable(of: SearchProductModel.self) { response in
               if let data = response.data, let json = String(data: data, encoding: .utf8) {
               }
            switch response.result {
              
            case .success(let productResponse):
              print(productResponse.results)

                completion(.success(productResponse.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchProducts(completion: @escaping (Result<[ResultProduct], any Error>) -> Void) {
      let url = Endpoints.Gets.all.path

        AF.request(url).validate().responseDecodable(of: ProductModel.self) { response in
            switch response.result {
            case .success(let productResponse):
              completion(.success(productResponse.results))
              print("DATA GET \(productResponse.results)")
            case .failure(let error) : completion(.failure(error))
            }
       
        }
    }
    
    func fetchProductDetail(id: Int, completion: @escaping (Result<DetailProductModel, any Error>) -> Void) {
      let url = Endpoints.Gets.detail(id: id).path

        AF.request(url).validate().responseDecodable(of: DetailProductModel.self) {response in
                switch response.result {
            case .success(let detailProductResponse): completion(.success(detailProductResponse))
            case .failure(let error) : completion(.failure(error))
            }
        }
    }
    
}
