//
//  DetailPresenter.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 21/07/25.
//

import Foundation

class DetailPresenter: ObservableObject {
  private let detailUsecase: DetailUsecase
  private let router = HomeRouter()
  
  @Published var detailProduct : DetailProductEntity?
  @Published var loadingState: Bool = false
  @Published var errorMessage: String?
  
  init(detailUsecase: DetailUsecase) {
    self.detailUsecase = detailUsecase
  }
  
  func getDetailProduct(id: Int) {
    loadingState = true
    detailUsecase.getDetailGame(id: id) { result in
      DispatchQueue.main.async {
        self.loadingState = false
        switch result {
        case .success(let success):
          self.detailProduct = success
        case .failure(let failure):
          self.errorMessage = failure.localizedDescription
        }
      }
    }
  }
}
