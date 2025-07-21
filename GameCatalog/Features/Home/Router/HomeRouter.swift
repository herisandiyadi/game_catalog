//
//  HomeRouter.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 17/07/25.
//

import SwiftUI

class HomeRouter {
  
  func makeDetailView(for id: Int) -> some View {
//    let presenter = Detail
    return DetailGameView(id: id)
  }
}
