//
//  CustomPlaceholderTextfield.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 06/05/25.
//

import SwiftUI

struct CustomPlaceholderTextField: View {
    @Binding var text: String
    var placeholder: String
    var placeholderColor: Color = .gray
    var textColor: Color = .black

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(placeholderColor)
                    .padding(.leading, 16)
            }

            TextField("", text: $text)
                .foregroundColor(textColor)
                .padding(10)
        }
    }
}
