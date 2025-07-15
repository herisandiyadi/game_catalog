//
//  GameCatalogApp.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 06/07/25.
//

import SwiftUI

@main
struct GameCatalogApp: App {
    @StateObject var favoriteViewModel = FavoriteViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(favoriteViewModel)
        }
    }
}
