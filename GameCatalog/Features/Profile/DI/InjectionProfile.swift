//
//  InjectionProfile.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 24/07/25.
//

import Swinject

extension DIContainer {
  func registerInjectionProfile() {
    container.register(ProfileUsecase.self) {_ in
      return ProfileInteractor()
    }
    
    container.register(ProfilePresenter.self) { resolver in
      let usecase = resolver.resolve(ProfileUsecase.self)!
      return ProfilePresenter(useCase: usecase)
    }
    
    container.register(ProfileRouter.self) { _ in
        ProfileRouter()
    }
  }
}
