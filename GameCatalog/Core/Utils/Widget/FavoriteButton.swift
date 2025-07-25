//
//  FavoriteButton.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 11/07/25.
//

import SwiftUI
import Combine

struct FavoriteButton: View {
  let favoriteEntity: FavoriteEntity
  @State private var cancellables = Set<AnyCancellable>()
  @StateObject private var presenter: FavoritePresenter = DIContainer.shared.resolve(FavoritePresenter.self)
    @State private var isFavorited: Bool = false

    var body: some View {
        Button(action: {
            if isFavorited {
              presenter.deleteFavorite(id: favoriteEntity.gameId)
            } else {
              presenter.addFavorite(favoriteEntity)
            }
            isFavorited.toggle()
        }) {
            Image(systemName: isFavorited ? "heart.fill" : "heart")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(isFavorited ? .red : .gray)
        }
        .onAppear {
          bindFavoriteStatus()
//          isFavorited = presenter.isFavoriteExist(id: favoriteEntity.gameId)
        }
    }
  
  private func bindFavoriteStatus(){
    presenter.isFavoritePublisher(gameId: favoriteEntity.gameId).receive(on: RunLoop.main).sink{ isFavorited in self.isFavorited = isFavorited }.store(in: &cancellables)
  }
}
