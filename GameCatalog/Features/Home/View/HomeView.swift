//
//  HomeView.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 06/07/25.
//
import SwiftUI

struct HomeView: View {
    @StateObject private var presenter: HomePresenter = DIContainer.shared.resolve(HomePresenter.self)
    @EnvironmentObject var favoriteViewModel: FavoriteViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()

                contentView
            }
            .onAppear {
                presenter.loadGames()
            }
        }
    }

    @ViewBuilder
    private var contentView: some View {
        if presenter.loadingState {
            loadingView
        } else if !presenter.errorMessage.isEmpty {
            errorView(message: presenter.errorMessage)
        } else {
            gameListView
        }
    }

    private var loadingView: some View {
        ProgressView("Loading...")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(.white)
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
    }

    private func errorView(message: String) -> some View {
        Text("Error: \(message)")
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var gameListView: some View {
      
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(presenter.productEntity, id: \.id) { product in
                    presenter.linkBuilder(for: product.id) {
                        CustomCardView(
                            id: product.id,
                            title: product.name,
                            imageUrl: product.backgroundImage,
                            rating: product.rating,
                            ratingCount: product.ratingsCount,
                            releaseDate: product.released,
                            platform: product.parentPlatforms
                        )
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.top, 8)
        }
        // Refreshable bisa kamu tambahkan kalau perlu
    }
}

#Preview {
    HomeView().environmentObject(FavoriteViewModel())
}
