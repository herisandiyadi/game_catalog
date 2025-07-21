//
//  SearchRouter.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 21/07/25.
//

import SwiftUI

class SearchRouter {
  func makeDetailView(for id: Int) -> some View {
    return DetailGameView(id: id)
  }
}
