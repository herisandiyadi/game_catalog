//
//  ProductViewModel.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 07/07/25.
//

import Foundation
import Alamofire


class ProductViewModel: ObservableObject {
    @Published var products: [ResultProduct] = []
    @Published var detailProduct: DetailProductModel?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let productService: ProductServiceProtocol
    
    init(productService: ProductServiceProtocol = ProductService()) {
        self.productService = productService
        fetchProduct()
    }
    
    func fetchProduct() {
        isLoading = true
        errorMessage = nil
        
        productService.fetchProducts { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let products):
                    self?.products = products
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
            
        }
    }
    
    func fetchDetailProduct(id: Int) {
        isLoading = true
        errorMessage = nil
        
        productService.fetchProductDetail(id: id) { [weak self] result in DispatchQueue.main.async {
            self?.isLoading = false
            switch result {
            case .success(let detailProduct):
                self?.detailProduct = detailProduct
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
            
        }
    }
    
}
