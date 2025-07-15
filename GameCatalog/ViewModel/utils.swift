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
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.locale = Locale(identifier: "id_ID")
    
    if let date = dateFormatter.date(from: tanggalString) {
        dateFormatter.dateFormat = "d-MM-yyyy"
        return dateFormatter.string(from: date)
    } else {
        return "Format tidak valid"
    }
}

func buildFavoriteModel(id: Int, title: String, imageUrl: String?, releaseDate: String, ratingCount: Int, rating: Double, platform: [ParentPlatform]) -> FavoriteModel {
    let fav = FavoriteModel()
    fav.gameId = id
    fav.name = title
    fav.image = imageUrl ?? ""
    fav.rating = rating
    fav.releaseDate = releaseDate
    fav.platforms = platform.map { $0.platform.name }.joined(separator: ", ")
    fav.ratingCount = ratingCount
    return fav
}

func parsePlatforms(from string: String) -> [ParentPlatform] {
    let names = string.components(separatedBy: ", ").map { $0.trimmingCharacters(in: .whitespaces) }
    return names.map { name in
        ParentPlatform(platform: Platform(id:0, name: name, slug: ""))
    }
}


