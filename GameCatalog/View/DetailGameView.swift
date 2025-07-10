//
//  DetailGameView.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 06/05/25.
//

import SwiftUI

struct DetailGameView: View {
    let id: Int
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = ProductViewModel()
    
    var body: some View {
        
        ZStack { Color("BackgroundColor")
                .ignoresSafeArea()
                   if viewModel.isLoading {
                       ProgressView("Loading...")
                           .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) .foregroundColor(.white)
                               .progressViewStyle(CircularProgressViewStyle(tint: .white))
                   } else if let error = viewModel.errorMessage {
                       Text("Error: \(error)")
                           .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) .foregroundColor(.white)
                   } else if let detailProduct = viewModel.detailProduct {
                       let ratings = String(format: "%.1f", detailProduct.rating)

                       VStack(spacing: 0) {
                           
                           HStack {
                               Text(detailProduct.name)
                                   .font(.system(size: 24, weight: .semibold, design: .rounded))
                                   .foregroundColor(.white)
                               
                           }
                           .padding(16)
                           ScrollView {
                               VStack(alignment: .leading, spacing: 16) {
                                   Rectangle()
                                       .fill(Color.gray.opacity(0.3))
                                       .overlay(
                                        AsyncImage(url: URL(string: detailProduct.backgroundImage)) { image in
                                               image
                                                   .resizable()
                                                   .scaledToFill()
                                           } placeholder: {
                                               ProgressView()  .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                           }
                                       )
                                       .frame(height: 208)
                                       .clipShape(
                                           UnevenRoundedRectangle(
                                               topLeadingRadius: 8,
                                               bottomLeadingRadius: 0,
                                               bottomTrailingRadius: 0,
                                               topTrailingRadius: 0
                                           )
                                       ).listRowInsets(EdgeInsets())
                                       .listRowBackground(Color.clear)
                                   
                                   HStack(spacing: 8) {
                                       ForEach(detailProduct.parentPlatforms, id: \.platform.name) { parent in
                                           if let iconName = platformIconMap.first(where: { parent.platform.name.contains($0.key) })?.value {
                                               Image(iconName)
                                                   .resizable()
                                                   .frame(width: 16, height: 16)
                                           }
                                       }
                                   }

                                   HStack(spacing: 8){
                                       Rectangle()
                                           .fill(Color("GreyColor"))
                                           .frame(width: 52, height: 20)
                                           .overlay(
                                               HStack {
                                                   Image(systemName: "star.fill")
                                                       .resizable()
                                                       .scaledToFit()
                                                       .frame(width: 12, height: 12)
                                                       .foregroundColor(.white)
                                                   
                                                   Text(ratings)
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
                                                   
                                                   Text("\(detailProduct.ratingsCount)")
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
                                   }
                                   
                                   Text("Description")
                                       .font(.system(size: 24, weight: .semibold, design: .rounded))
                                       .foregroundColor(.white).padding(.top, 16)
                                   Text(detailProduct.descriptionRaw)
                                       .font(.system(size: 18, weight: .light, design: .rounded))
                                       .foregroundColor(.white).opacity(0.8)
                               }
                               .padding()
                           }
                           
                       } .background(Color("BackgroundColor").ignoresSafeArea())
                       .navigationBarBackButtonHidden(true)
                           .navigationBarItems(leading:
                                                   Button(action: {
                               presentationMode.wrappedValue.dismiss()
                           }) {
                               Image(systemName: "chevron.left")
                                   .foregroundColor(.white)
                           }
                           )
                   }
               }
               .onAppear {
                   viewModel.fetchDetailProduct(id: id)
               }
    }
}


#Preview {
    DetailGameView(id: 100)
}
