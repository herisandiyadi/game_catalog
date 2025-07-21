//
//  InjectionHome.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 17/07/25.
//

import Swinject

extension DIContainer {
  func registerInjectionHome() {
    container.register(HomeUsecase.self) {
      resolver in
      let repositoryProtocol = resolver.resolve(ProductRepositoryProtocol.self)!
      return HomeInteractor(productRepository: repositoryProtocol)
    }
    
    container.register(HomePresenter.self) {
      resolver in
      let useCase = resolver.resolve(HomeUsecase.self)!
      return HomePresenter(homeUsecase: useCase)
    }
    
    container.register(HomeRouter.self) { _ in
      HomeRouter()
      
    }
  }
}
