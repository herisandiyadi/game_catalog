//
//  SearchViewModel.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 09/07/25.
//

import Foundation
import Alamofire

class SearchViewModel: ObservableObject{
    @Published var searchProducts: [SearchResult] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let productService: ProductServiceProtocol
    
    init(productService: ProductServiceProtocol = ProductService()) {
        self.productService = productService
    }
    
    func searchProduct(q: String){
        isLoading = true
        errorMessage = nil
        
        productService.searchProduct(q: q) { [weak self] result in DispatchQueue.main.async {
            self?.isLoading = false
            switch result {
            case .success(let searchProducts):
                self?.searchProducts = searchProducts
            case .failure(let error):
                self?.errorMessage = error.localizedDescription

            }
            }
        }
       
    }
}
