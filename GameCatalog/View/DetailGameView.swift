//
//  DetailGameView.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 07/07/25.
//

import SwiftUI

struct DetailGameView: View {
    let id: Int
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = ProductViewModel()
    @EnvironmentObject var favoriteViewModel: FavoriteViewModel

    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            
            if viewModel.isLoading {
                loadingView
            } else if let error = viewModel.errorMessage {
                errorView(message: error)
            } else if let product = viewModel.detailProduct {
                detailContent(for: product)
            }
        }
        .onAppear {
            viewModel.fetchDetailProduct(id: id)
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func detailContent(for product: DetailProductModel) -> some View {
        let ratings = String(format: "%.1f", product.rating)

        return VStack(spacing: 0) {
            headerView(product: product)

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    gameImageView(url: product.backgroundImage)

                    platformIcons(product.parentPlatforms)

                    statsRow(
                        rating: ratings,
                        ratingCount: product.ratingsCount,
                        released: product.released ?? ""
                    )

                    Text("Description")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .padding(.top, 8)

                    Text(product.descriptionRaw)
                        .font(.body)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding()
            }
        }
        .background(Color("BackgroundColor").ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }

    private func headerView(product: DetailProductModel) -> some View {
        HStack {
            Text(product.name)
                .font(.system(size: 24, weight: .semibold, design: .rounded))
                .foregroundColor(.white)

            Spacer()

            FavoriteButton(
                favoriteModel: buildFavoriteModel(
                    id: product.id,
                    title: product.name,
                    imageUrl: product.backgroundImage,
                    releaseDate: product.released ?? "",
                    ratingCount: product.ratingsCount,
                    rating: product.rating,
                    platform: product.parentPlatforms
                )
            )
        }
        .padding(16)
    }

    private func gameImageView(url: String) -> some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .overlay(
                AsyncImage(url: URL(string: url)) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white))
                }
            )
            .frame(height: 208)
            .clipShape(UnevenRoundedRectangle(topLeadingRadius: 8))
    }

    private func platformIcons(_ platforms: [ParentPlatform]) -> some View {
        HStack(spacing: 8) {
            ForEach(platforms, id: \.platform.name) { parent in
                if let iconName = platformIconMap.first(where: { parent.platform.name.contains($0.key) })?.value {
                    Image(iconName)
                        .resizable()
                        .frame(width: 16, height: 16)
                }
            }
        }
    }

    private func statsRow(rating: String, ratingCount: Int, released: String) -> some View {
        HStack(spacing: 8) {
            statItem(systemName: "star.fill", text: rating)
            statItem(systemName: "eye.fill", text: "\(ratingCount)")
            releaseItem(date: released)
        }
    }

    private func statItem(systemName: String, text: String) -> some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(Color("GreyColor"))
            .frame(width: 65, height: 20)
            .overlay(
                HStack(spacing: 4) {
                    Image(systemName: systemName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.white)
                    Text(text)
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                }
            )
    }

    private func releaseItem(date: String) -> some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(Color("GreyColor"))
            .frame(width: 160, height: 20)
            .overlay(
                HStack(spacing: 4) {
                    Text("Released:")
                        .font(.system(size: 10))
                        .foregroundColor(.white)
                    Text(formatTanggal(date))
                        .font(.system(size: 10))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 4)
            )
    }

    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.white)
        }
    }
}


#Preview {
    DetailGameView(id: 100)
        .environmentObject(FavoriteViewModel())
}
