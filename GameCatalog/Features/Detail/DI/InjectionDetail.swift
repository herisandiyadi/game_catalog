//
//  InjectionDetail.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 21/07/25.
//

import Swinject

extension DIContainer {
  func registerDetailInjection() {
    container.register(DetailUsecase.self) {
      resolver in
      let repositoryProtocol = resolver.resolve(ProductRepositoryProtocol.self)!
      return DetailInteractor(productRepository: repositoryProtocol)
    }
    
    container.register(DetailPresenter.self){
      resolver in
      let useCase = resolver.resolve(DetailUsecase.self)!
      return DetailPresenter(detailUsecase: useCase)
    }
  }
}
