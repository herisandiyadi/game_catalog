//
//  FavoritePresenter.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 22/07/25.
//

import Foundation
import SwiftUI
import RealmSwift

class FavoritePresenter: ObservableObject {
  private let favoriteUseCase: FavoriteUsecase
  private let router = FavoriteRouter()
  private var notificationToken: NotificationToken?

  
  @Published var favorites: [FavoriteEntity] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  
  init(favoriteUseCase: FavoriteUsecase) {
    self.favoriteUseCase = favoriteUseCase
    loadFavorites()
  }
  
  func loadFavorites() {
    loadingState = true
    notificationToken = favoriteUseCase.observeFavorites { [weak self] result in
      self?.loadingState = false
      switch result {
      case .success(let favorites):
        self?.favorites = favorites
      case .failure(let error):
        self?.errorMessage = error.localizedDescription
      }
      
    }
  }
  
  func linkBuilder<Content: View>(for id: Int, @ViewBuilder content: () -> Content) -> some View {
    NavigationLink(destination: router.makeDetailView(for: id)) { content() }
  }
}
