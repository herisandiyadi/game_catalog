//
//  FavoriteButton.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 11/07/25.
//

import SwiftUI

struct FavoriteButton: View {
    let favoriteModel: FavoriteModel
    @EnvironmentObject var favoriteViewModel: FavoriteViewModel
    @State private var isFavorited: Bool = false

    var body: some View {
        Button(action: {
            if isFavorited {
                favoriteViewModel.deleteFavorite(gameId: favoriteModel.gameId)
            } else {
                favoriteViewModel.addFavorite(favoriteModel)
            }
            isFavorited.toggle()
        }) {
            Image(systemName: isFavorited ? "heart.fill" : "heart")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(isFavorited ? .red : .gray)
        }
        .onAppear {
            isFavorited = favoriteViewModel.isFavorite(gameId: favoriteModel.gameId)
        }
    }
}
