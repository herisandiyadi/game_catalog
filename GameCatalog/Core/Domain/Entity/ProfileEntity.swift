//
//  ProfileEntity.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 24/07/25.
//

import Foundation

class ProfileEntity: Identifiable, Equatable {
  var imagePath: String?
    var name: String
    var title: String
    var quote: String
  
  init(imagePath: String? = nil, name: String, title: String, quote: String) {
    self.imagePath = imagePath
    self.name = name
    self.title = title
    self.quote = quote
  }
  
  static func == (lhs: ProfileEntity, rhs: ProfileEntity) -> Bool {
    return lhs.imagePath == rhs.imagePath &&
    lhs.name == rhs.name &&
    lhs.title == rhs.title &&
    lhs.quote == rhs.quote
  }
}
