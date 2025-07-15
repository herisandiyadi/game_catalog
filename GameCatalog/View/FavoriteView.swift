//
//  FavoriteView.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 11/07/25.
//

import SwiftUI

struct FavoriteView: View {
    @State private var selectedCardID: Int? = nil
    @EnvironmentObject var viewModel: FavoriteViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                contentView
            }
            .onChange(of: viewModel.favorites) { newFavorites in
                if newFavorites.isEmpty {
                    selectedCardID = nil
                }
            }
          
            .navigationDestination(isPresented: Binding<Bool>(
                get: { selectedCardID != nil },
                set: { if !$0 { selectedCardID = nil } }
            )) {
                if let id = selectedCardID {
                    DetailGameView(id: id)
                }
            }
        }
    }

    @ViewBuilder
    private var contentView: some View {
        if viewModel.favorites.isEmpty {
            emptyStateView
        } else {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.favorites, id: \.gameId) { product in
                        buildCardView(for: product)
                    }
                }
                .padding(.top, 8)
            }
        }
    }

    private var emptyStateView: some View {
        Text("No favorites yet")
            .foregroundColor(.gray)
            .font(.body)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    @ViewBuilder
    private func buildCardView(for product: FavoriteModel) -> some View {
        CustomCardView(
            id: product.gameId,
            title: product.name,
            imageUrl: product.image,
            rating: product.rating,
            ratingCount: product.ratingCount,
            releaseDate: product.releaseDate,
            platform: parsePlatforms(from: product.platforms)
        )
        .onTapGesture {
            selectedCardID = product.gameId
        }
        .padding(.horizontal)
    }
}
