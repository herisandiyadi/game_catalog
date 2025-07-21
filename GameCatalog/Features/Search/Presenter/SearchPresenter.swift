//
//  SearchPresenter.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 21/07/25.
//
import Foundation
import SwiftUI


class SearchPresenter: ObservableObject {
  private let searchUsecase: SearchUsecase
  private let router = SearchRouter()
  @Published var searchResult: [SearchResultEntity] = []
  @Published var errorMessage: String?
  @Published var isLoading: Bool = false
  
  init(searchUsecase: SearchUsecase) {
    self.searchUsecase = searchUsecase
  }
  
  func searchGames(q: String) {
    isLoading = true
    searchUsecase.searchProduct(q: q) { result in
      DispatchQueue.main.async {
        self.isLoading = false
        switch result {
        case .success(let success):
          self.searchResult = success
        case .failure(let error):
          self.errorMessage = error.localizedDescription
        }
      }
      
    }
  }
  
  func linkBuilder<Content: View>(
    for id: Int, @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: router.makeDetailView(for: id)
    ) { content() }
  }
  
}
