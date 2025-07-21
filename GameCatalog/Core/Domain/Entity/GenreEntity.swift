//
//  GenreEntity.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 16/07/25.
//

import Foundation

struct GenreEntity: Identifiable {
  let id: Int
  let name, slug: String
  let gamesCount: Int
  let imageBackground: String
}
