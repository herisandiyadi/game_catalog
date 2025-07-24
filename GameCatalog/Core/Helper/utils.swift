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

func buildFavoriteModel(
    id: Int,
    title: String,
    imageUrl: String?,
    releaseDate: String,
    ratingCount: Int,
    rating: Double,
    platform: [ParentPlatformEntity]
) -> FavoriteEntity {
    
    let platforms = platform.map { $0.platform.name }.joined(separator: ", ")
    
    return FavoriteEntity(
        gameId: id,
        name: title,
        image: imageUrl ?? "",
        rating: rating,
        releaseDate: releaseDate,
        platforms: platforms,
        ratingCount: ratingCount
    )
}

func parsePlatforms(from string: String) -> [ParentPlatformEntity] {
    let names = string.components(separatedBy: ", ").map { $0.trimmingCharacters(in: .whitespaces) }
    return names.map { name in
        ParentPlatformEntity(platform: PlatformEntity(id:0, name: name, slug: ""))
    }
}


