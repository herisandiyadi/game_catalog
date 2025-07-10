//
//  utils.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 08/07/25.
//

import Foundation


let platformIconMap: [String: String] = [
    "Xbox": "ic_xbox",
    "PC": "ic_windows",
    "PlayStation": "ic_ps",
    "Nintendo": "ic_nintendo",
    "Gameboy": "ic_gameboy"

]

func formatTanggal(_ tanggalString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd" // Format input
    dateFormatter.locale = Locale(identifier: "id_ID") // Gunakan Bahasa Indonesia
    
    if let date = dateFormatter.date(from: tanggalString) {
        dateFormatter.dateFormat = "d MMMM yyyy" // Format output
        return dateFormatter.string(from: date)
    } else {
        return "Format tidak valid"
    }
}
