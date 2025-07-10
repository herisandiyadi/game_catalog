//
//  ProductViewModel.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 07/07/25.
//

import Foundation
import Alamofire


class ProductViewModel: ObservableObject {
    @Published var products: [Result] = []
    @Published var detailProduct: DetailProductModel?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let apiKey = "2e3a8ba34fa54075bf379c98b54cf51e"
    private let baseUrl = "https://api.rawg.io/api/games"
    
    func fetchProduct() {
        isLoading = true
        errorMessage = nil
        
        let url = "\(baseUrl)?key=\(apiKey)"
        
        AF.request(url).validate().responseDecodable(of: ProductModel.self) { response in
            DispatchQueue.main.async {
                self.isLoading = false
                switch response.result {
                case .success(let productResponse):
                    self.products = productResponse.results
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }

    }
    
    func fetchDetailProduct(id: Int){
        isLoading = true
        errorMessage = nil
        
        let url = "\(baseUrl)/\(id)?key=\(apiKey)"
        
        AF.request(url).validate().responseDecodable(of: DetailProductModel.self) { response in
            DispatchQueue.main.async {
                self.isLoading = false
                switch response.result {
                case .success(let detailResponse):
                    self.detailProduct = detailResponse
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
              
    }
    
}
