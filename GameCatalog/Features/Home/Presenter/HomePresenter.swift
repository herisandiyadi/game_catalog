//
//  HomePresenter.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 17/07/25.
//

import Foundation
import SwiftUI

class HomePresenter: ObservableObject {
  private let homeUsecase: HomeUsecase
  private let router = HomeRouter()
  
  @Published var productEntity: [ProductEntity] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  
  init(homeUsecase: HomeUsecase) {
    self.homeUsecase = homeUsecase
    loadGames()
  }
  
  func loadGames(){
    loadingState = true
    homeUsecase.getProductAll { result in
      DispatchQueue.main.async {
        self.loadingState = false
        switch result {
        case .success(let resultSuccess):
          self.productEntity = resultSuccess
        case .failure(let error):
          self.errorMessage = error.localizedDescription
        }
      }
    }
  }
  
  func linkBuilder<Content: View>(
    for id: Int,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
      destination: router.makeDetailView(for: id)
    ) { content() }
  }
}
