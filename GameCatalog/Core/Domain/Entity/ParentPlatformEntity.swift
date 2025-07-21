//
//  ParentPlatformEntity.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 16/07/25.
//

import Foundation

struct ParentPlatformEntity: Identifiable {
  var id: Int { platform.id }
  let platform: PlatformEntity
}

struct PlatformEntity: Identifiable {
  let id: Int
  let name, slug: String
}
