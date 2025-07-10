//
//  CustomCardView.swift
//  SubmissionTest
//
//  Created by Heri Sandiyadi on 03/07/25.
//

import SwiftUI

struct CustomCardView: View {
    let title: String
    let imageUrl: String?
    let rating: Double
    let ratingCount: Int
    let platform: [ParentPlatform]

    var body: some View {
        
        let ratings = String(format: "%.1f", rating)

        VStack(alignment: .leading, spacing: 0) {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .overlay(
                    Group {
                        if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
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
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)

            VStack(alignment: .leading) {
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
                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)

            }
            .padding(.top, 16)
            .padding(.horizontal,16)
            
            HStack(spacing: 8){
                Rectangle()
                    .fill(Color("GreyColor"))
                    .frame(width: 65, height: 20)
                    .overlay(
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                                .foregroundColor(.white)
                            
                            Text("\(ratings)")
                                .font(.system(size: 14, weight: .regular, design: .rounded))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    )
                    .clipShape(
                        UnevenRoundedRectangle(
                            topLeadingRadius: 4,
                            bottomLeadingRadius: 4,
                            bottomTrailingRadius: 4,
                            topTrailingRadius: 4
                        )
                    )
                    .listRowInsets(EdgeInsets())
                   
                    .padding(.bottom, 4)
                
                Rectangle()
                    .fill(Color("GreyColor"))
                    .frame(maxWidth: 85)
                    .frame(height: 20)
                    .overlay(
                        HStack {
                            Image(systemName: "eye.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                                .foregroundColor(.white)
                            
                            Text("\(ratingCount)")
                                .font(.system(size: 14, weight: .regular, design: .rounded))
                                .foregroundColor(.white)
                        }.padding(.horizontal, 4)
                    )
                   
                    .clipShape(
                        UnevenRoundedRectangle(
                            topLeadingRadius: 4,
                            bottomLeadingRadius: 4,
                            bottomTrailingRadius: 4,
                            topTrailingRadius: 4
                        )
                    )
                    .listRowInsets(EdgeInsets())
                    .padding(.bottom, 4)
            }.padding(.horizontal, 16)
            
            Spacer()
        }
        .frame(height: 315)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets())
        .background(Color("CardColor"))
        .cornerRadius(8)
        .shadow(color: Color("GreyColor"), radius: 2, x: 0, y: 1)
    }
}
