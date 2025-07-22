//
//  DIContainer.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 16/07/25.
//

import Swinject
import SwiftUI

class DIContainer {
  static let shared = DIContainer()
  private(set) var container = Container()
  
  private init() {
    registerDependencies()
    registerInjectionHome()
    registerDetailInjection()
    registerInjectionSearch()
    registerInjectionFavorite()
  }
  
  private func registerDependencies(){
    container.register(ProductServiceProtocol.self) { _ in
      ProductService()
    }
    
    container.register(FavoriteLocalDataSource.self) { _ in
        FavoriteLocalDataSourceImpl()
    }
    
    container.register(ProductRepositoryProtocol.self) { resolver in
      let serviceProtocol = resolver.resolve(ProductServiceProtocol.self)!
      return ProductRepositoryImpl(productService: serviceProtocol)
    }
    
    container.register(FavoriteRepositoryProtocol.self) { resolver in
      let serviceProtocol = resolver.resolve(FavoriteLocalDataSource.self)!
      return FavoriteRepositoryImpl(favoriteLocalDataSource: serviceProtocol)
    }
  }
  
  func resolve<T>(_ type: T.Type) -> T {
    guard let dependency = container.resolve(type) else {
        fatalError("Could not resolve \(type) is not Registered")
      }
    return dependency
    }
}
