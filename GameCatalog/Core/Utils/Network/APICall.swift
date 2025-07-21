//
//  APICall.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 17/07/25.
//

import Foundation

struct API {
  static let baseUrl = "https://api.rawg.io/api/games"
  static let apiKey = Bundle.main.infoDictionary?["RAWG_API_KEY"] as? String ?? ""

}

protocol Endpoint {
  var path: String { get }
}

enum Endpoints {
  enum Gets: Endpoint {
    case all
    case detail(id: Int)
    case search(query: String)
    
    var path: String {
      switch self {
      case .all:
        return "\(API.baseUrl)?key=\(API.apiKey)"
      
      case .detail(let id):
        return "\(API.baseUrl)/\(id)?key=\(API.apiKey)"
      
      case .search(let query):
        return "\(API.baseUrl)?key=\(API.apiKey)&search=\(query)"
      }
   
    }
  }
}
