//
//  FavoritePresenter.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 22/07/25.
//

import Foundation
import SwiftUI
import RealmSwift
import Combine

class FavoritePresenter: ObservableObject {
  private let favoriteUseCase: FavoriteUsecase
  private var cancellables: Set<AnyCancellable> = []
  private let router = FavoriteRouter()
  
  @Published var favorites: [FavoriteEntity] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  
  init(favoriteUseCase: FavoriteUsecase) {
    self.favoriteUseCase = favoriteUseCase
    observeFavorites()
  }
  
  func observeFavorites() {
    loadingState = true
    favoriteUseCase.getFavoritePublisher()
      .receive(on: RunLoop.main )
      .sink { [weak self] favorites in
      self?.favorites = favorites
      self?.loadingState = false
    }.store(in: &cancellables)
  }
  
  func isFavoritePublisher(gameId: Int) -> AnyPublisher<Bool, Never> {
    favoriteUseCase.isFavoritePublisher(gameId: gameId)
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
  
  func linkBuilder<Content: View>(for id: Int, @ViewBuilder content: () -> Content) -> some View {
    NavigationLink(destination: router.makeDetailView(for: id)) { content() }
  }
  
}
