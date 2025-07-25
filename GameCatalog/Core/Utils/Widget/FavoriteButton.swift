//
//  FavoriteButton.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 11/07/25.
//

import SwiftUI

struct FavoriteButton: View {
  let favoriteEntity: FavoriteEntity
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
          isFavorited = presenter.isFavoriteExist(id: favoriteEntity.gameId)
        }
    }
}
