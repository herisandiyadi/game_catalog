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
    
    let apiKey = Bundle.main.infoDictionary?["RAWG_API_KEY"] as? String ?? ""
    private let baseUrl = "https://api.rawg.io/api/games"
    
    func searchProduct(q: String){
        isLoading = true
        errorMessage = nil
        
        let url = "\(baseUrl)?key=\(apiKey)&search=\(q)"

        AF.request(url).validate().responseDecodable(of: SearchProductModel.self) { response in
            DispatchQueue.main.async {
                self.isLoading = false
                switch response.result {
                case .success(let searchProduct):

                    self.searchProducts = searchProduct.results
                case .failure(let error):

                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
