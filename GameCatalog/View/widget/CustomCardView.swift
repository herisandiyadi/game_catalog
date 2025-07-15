//
//  CustomCardView.swift
//  SubmissionTest
//
//  Created by Heri Sandiyadi on 03/07/25.
//

import SwiftUI

struct CustomCardView: View {
    let id: Int
    let title: String
    let imageUrl: String?
    let rating: Double
    let ratingCount: Int
    let releaseDate: String?
    let platform: [ParentPlatform]
    @EnvironmentObject var favoriteViewModel: FavoriteViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            gameImageView
            gameInfoSection
            gameStatsSection
            Spacer()
        }
        .frame(height: 315)
        .background(Color("CardColor"))
        .cornerRadius(8)
        .shadow(color: Color("GreyColor"), radius: 2, x: 0, y: 1)
    }

    private var gameImageView: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .overlay(
                Group {
                    if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
                        AsyncImage(url: url) { image in
                            image.resizable().scaledToFill()
                        } placeholder: {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        }
                    } else {
                        Image("placeholder_img")
                            .resizable()
                            .scaledToFill()
                    }
                }
            )
            .frame(height: 208)
            .clipShape(
                UnevenRoundedRectangle(
                    topLeadingRadius: 8,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 8
                )
            )
    }

    private var gameInfoSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 8) {
                ForEach(platform, id: \.platform.name) { parent in
                    if let iconName = platformIconMap.first(where: { parent.platform.name.contains($0.key) })?.value {
                        Image(iconName)
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                }
            }

            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
        .padding(.top, 16)
        .padding(.horizontal, 16)
    }

    private var gameStatsSection: some View {
        HStack(spacing: 8) {
            statBox(icon: "star.fill", text: String(format: "%.1f", rating))
            statBox(icon: "eye.fill", text: "\(ratingCount)")
            releaseBox(date: releaseDate ?? "")
            Spacer()

            FavoriteButton(
                favoriteModel: buildFavoriteModel(
                    id: id,
                    title: title,
                    imageUrl: imageUrl,
                    releaseDate: releaseDate ?? "",
                    ratingCount: ratingCount,
                    rating: rating,
                    platform: platform
                )
            )
        }
        .padding(.horizontal, 16)
    }

    private func statBox(icon: String, text: String) -> some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(Color("GreyColor"))
            .frame(width: 65, height: 20)
            .overlay(
                HStack(spacing: 4) {
                    Image(systemName: icon)
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

    private func releaseBox(date: String) -> some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(Color("GreyColor"))
            .frame(width: 130, height: 20)
            .overlay(
                HStack(spacing: 4) {
                    Text("Released:")
                        .font(.system(size: 10))
                        .foregroundColor(.white)
                    Text(formatTanggal(date))
                        .font(.system(size: 10))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.horizontal, 4)
            )
    }
}

#Preview {
    CustomCardView(
        id: 1,
        title: "Dummy Game",
        imageUrl: nil,
        rating: 4.5,
        ratingCount: 1000,
        releaseDate: "2024-01-01",
        platform: [
            ParentPlatform(platform: Platform(id: 0, name: "PC", slug: "pc"))
        ]
    )
    .environmentObject(FavoriteViewModel())
}
