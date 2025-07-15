//
//  HomeView.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 06/07/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = ProductViewModel()
    @State private var selectedCardID: Int? = nil
    @EnvironmentObject var favoriteViewModel: FavoriteViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()

                contentView
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
        if viewModel.isLoading {
            loadingView
        } else if let error = viewModel.errorMessage {
            errorView(message: error)
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
                ForEach(viewModel.products, id: \.id) { product in
                    CustomCardView(
                        id: product.id,
                        title: product.name,
                        imageUrl: product.backgroundImage,
                        rating: product.rating,
                        ratingCount: product.ratingsCount,
                        releaseDate: product.released,
                        platform: product.parentPlatforms
                    )
                    .onTapGesture {
                        selectedCardID = product.id
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.top, 8)
        }
        .refreshable {
            viewModel.fetchProduct()
        }
    }
}


#Preview {
    HomeView().environmentObject(FavoriteViewModel())

}
