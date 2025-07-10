//
//  HTMLTextView.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 06/05/25.
//

import SwiftUI

struct HTMLTextView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.textColor = UIColor.white // Warna teks default
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        guard let data = htmlContent.data(using: .utf8) else { return }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        if let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            uiView.attributedText = attributedString
        }
    }
}

#Preview {
    HTMLTextView(htmlContent: "")
}
