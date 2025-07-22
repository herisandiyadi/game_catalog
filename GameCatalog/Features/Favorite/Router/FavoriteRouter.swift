//
//  FavoriteRouter.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 22/07/25.
//

import SwiftUI

class FavoriteRouter {
  func makeDetailView(for id: Int) -> some View {
    return DetailGameView(id: id)
  }
}
