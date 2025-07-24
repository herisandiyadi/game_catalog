//
//  FavoriteModel.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 11/07/25.
//

import Foundation
import RealmSwift

class FavoriteModel: Object, Identifiable {
    @Persisted(primaryKey: true) var gameId: Int
    @Persisted var name: String = ""
    @Persisted var image: String = ""
    @Persisted var rating: Double = 0.0
    @Persisted var releaseDate: String = ""
    @Persisted var platforms: String = ""
    @Persisted var ratingCount: Int = 0
    
}


