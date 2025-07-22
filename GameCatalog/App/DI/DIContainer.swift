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
    
    container.register(ProductRepositoryProtocol.self) { resolver in
      let serviceProtocol = resolver.resolve(ProductServiceProtocol.self)!
      return ProductRepositoryImpl(productService: serviceProtocol)
    }
    
    container.register(FavoriteLocalDataSource.self) { _ in
        FavoriteLocalDataSourceImpl()
    }
    
    container.register(FavoriteLocalDataSource.self) { resolver in
      let favoriteLocalDataSource = resolver.resolve(FavoriteLocalDataSource.self)!
      return FavoriteLocalDataSourceImpl()
    }
    
  }
  
  func resolve<T>(_ type: T.Type) -> T {
    guard let dependency = container.resolve(type) else {
        fatalError("Could not resolve \(type) is not Registered")
      }
    return dependency
    }
}
