//
//  InjectionFavorite.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 22/07/25.
//

import Swinject

extension DIContainer {
  func registerInjectionFavorite() {
    container.register(FavoriteUsecase.self) {
      resolver in
      let repositoryProtocol = resolver.resolve(FavoriteRepositoryProtocol.self)!
      return FavoriteInteractor(favoriteRepository: repositoryProtocol)
    }
    
    container.register(FavoritePresenter.self) {
      resolver in
      let useCase = resolver.resolve(FavoriteUsecase.self)!
      return FavoritePresenter(favoriteUseCase: useCase)
    }
    
    container.register(FavoriteRouter.self) { _ in
      FavoriteRouter()
    }
  }
}
