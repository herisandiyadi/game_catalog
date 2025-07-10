//
//  HomeView.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 06/07/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = ProductViewModel()
    @State private var selectedCard: Int? = nil

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                contentView
            }
            .onAppear {
                viewModel.fetchProduct()
            }
            .navigationDestination(isPresented: Binding<Bool>(
                get: { selectedCard != nil },
                set: { if !$0 { selectedCard = nil } }
            )) {
                if let id = selectedCard {
                    DetailGameView(id: id)
                }
            }
        }
    }

    @ViewBuilder
    private var contentView: some View {
        if viewModel.isLoading {
            ProgressView("Loading...")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .foregroundColor(.white)
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
        } else if let error = viewModel.errorMessage {
            Text("Error: \(error)")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        } else {
            List {
                ForEach(viewModel.products, id: \.id) { product in
                    CustomCardView(
                        title: product.name,
                        imageUrl: product.backgroundImage,
                        rating: product.rating,
                        ratingCount: product.ratingsCount,
                        releaseDate: product.released,
                        platform: product.parentPlatforms
                    )
                    .onTapGesture {
                        selectedCard = product.id
                    }
                    .listRowSeparator(.hidden)
                    .padding()
                }
            }
            .listStyle(PlainListStyle())
            .scrollContentBackground(.hidden) 
            .background(Color("BackgroundColor"))
        }
    }
}

#Preview {
    HomeView()
}
