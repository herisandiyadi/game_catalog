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
  
  deinit {
          notificationToken?.invalidate()
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
  
  func deleteFavorite(id: Int) {
    loadingState = true
    do {
      try favoriteUseCase.removeFavorite(gameId: id) { [weak self] result in
        DispatchQueue.main.async {
          self?.loadingState = false
          switch result {
          case .success:
            break
          case .failure(let error):
            self?.errorMessage = error.localizedDescription
          }
        }
      }
    }
  }
  
  func addFavorite(_ favorite: FavoriteEntity) {
    loadingState = true
    do {
      try favoriteUseCase.addFavorite(favoriteEntity: favorite) { [weak self] result in
        DispatchQueue.main.async {
          self?.loadingState = false
          switch result {
          case .success:
            break
          case .failure(let error):
            self?.errorMessage = error.localizedDescription
          }
        }
      }
    }
  }
  
  func isFavoriteExist(id: Int) -> Bool {
    favoriteUseCase.isFavorite(gameId: id)
  }
  
  func linkBuilder<Content: View>(for id: Int, @ViewBuilder content: () -> Content) -> some View {
    NavigationLink(destination: router.makeDetailView(for: id)) { content() }
  }
  
}
