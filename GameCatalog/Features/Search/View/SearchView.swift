//
//  SearchView.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 08/07/25.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
  @StateObject private var presenter: SearchPresenter = DIContainer.shared.resolve(SearchPresenter.self)
    @EnvironmentObject var favoriteViewModel: FavoriteViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()

                VStack(spacing: 16) {
                    SearchBarView(searchText: $searchText)
                        .padding(.horizontal)

                    contentView
                }
//                .padding(.top, 30)
//                .navigationDestination(isPresented: Binding<Bool>(
//                    get: { selectedCardID != nil },
//                    set: { if !$0 { selectedCardID = nil } }
//                )) {
//                    if let id = selectedCardID {
//                        DetailGameView(id: id)
//                    }
//                }
            }
            .onSubmit {
                handleSearch()
            }
        }
    }

    private func handleSearch() {
        let trimmed = searchText.trimmingCharacters(in: .whitespaces)
        if !trimmed.isEmpty {
          presenter.searchGames(q: trimmed)
        } else {
          presenter.searchResult = []
        }
    }

    @ViewBuilder
    private var contentView: some View {
        if presenter.isLoading {
            loadingView
        } else if let error = presenter.errorMessage {
            errorView(error)
        } else if presenter.searchResult.isEmpty && !searchText.isEmpty {
            emptyResultsView
        } else {
            resultsListView
        }
    }

    private var loadingView: some View {
        ProgressView("Loading...")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(.white)
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
    }

    private func errorView(_ message: String) -> some View {
        Text("Error: \(message)")
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var emptyResultsView: some View {
        Text("No results found")
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var resultsListView: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            ScrollView{
                LazyVStack(spacing: 16){
                  ForEach(presenter.searchResult, id: \.id) { product in
                        CustomCardView(
                            id: product.id,
                            title: product.name,
                            imageUrl: product.backgroundImage,
                            rating: product.rating,
                            ratingCount: product.ratingsCount,
                            releaseDate: product.released,
                            platform: product.parentPlatforms
                        )
//                        .onTapGesture {
//                            selectedCardID = product.id
//                        }
                        .padding(.horizontal)
                    }
                    .listRowBackground(Color.clear)
                }  .padding(.top, 8)
            }

        }
    }


}

#Preview {
    SearchView()
        .environmentObject(FavoriteViewModel())
}

