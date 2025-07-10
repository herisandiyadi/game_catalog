//
//  SearchView.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 08/07/25.
//

import SwiftUI
import Alamofire

struct SearchView: View {
    @State private var searchText = ""
    @StateObject var viewModel = SearchViewModel()
    @State private var selectedCard: Int? = nil

    var body: some View {
        NavigationStack {
                   ZStack {
                       Color("BackgroundColor")
                           .ignoresSafeArea()

                       VStack {
                           SearchBarView(searchText: $searchText)
                               .padding(.horizontal)

                           contentView
                       }
                       .navigationDestination(isPresented: Binding<Bool>(
                           get: { selectedCard != nil },
                           set: { if !$0 { selectedCard = nil } }
                       )) {
                           if let id = selectedCard {
                               DetailGameView(id: id)
                           }
                       }
                   }.padding(.top, 30)
                .onSubmit {
                                  let trimmed = searchText.trimmingCharacters(in: .whitespaces)
                                  if !trimmed.isEmpty {
                                      viewModel.searchProduct(q: trimmed)
                                  } else {
                                      viewModel.searchProducts = []
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
           } else if viewModel.searchProducts.isEmpty && !searchText.isEmpty {
               Text("No results found")
                   .foregroundColor(.gray)
                   .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
           } else {
               List {
                   ForEach(viewModel.searchProducts, id: \.id) { product in
                       CustomCardView(
                           title: product.name,
                           imageUrl: product.backgroundImage,
                           rating: product.rating,
                           ratingCount: product.ratingsCount,
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
    SearchView()
}
