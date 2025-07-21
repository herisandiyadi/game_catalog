//
//  SearchBarView.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 07/07/25.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            CustomPlaceholderTextField(
                text: $searchText,
                placeholder: "Search...",
                placeholderColor: Color.gray,
                textColor: .white
            )
            .background(Color("GreyColor"))
            .cornerRadius(30)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .strokeBorder(Color("BackgroundColor"), lineWidth: 1)
            )
            .accentColor(.white)
            .padding(.horizontal)

            if !searchText.isEmpty {
                Button(action: { searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color("GreyColor"))
                }
            }
        }
    }
}
