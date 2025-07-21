//
//  InjectionSearch.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 21/07/25.
//

import Swinject

extension DIContainer {
  func registerInjectionSearch() {
    container.register(SearchUsecase.self) { resolver in
      let respositoryProtocol = resolver.resolve(ProductRepositoryProtocol.self)!
      return SearchInteractor(productRepository: respositoryProtocol)
    }
    
    container .register(SearchPresenter.self) {
      resolver in
      let useCase = resolver.resolve(SearchUsecase.self)!
      return SearchPresenter(searchUsecase: useCase)
    }
    container.register(SearchRouter.self) { _ in
      SearchRouter()
      
    }
  }
}

