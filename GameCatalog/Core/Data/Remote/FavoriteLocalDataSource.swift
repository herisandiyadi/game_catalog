//
//  FavoriteLocalDataSource.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 22/07/25.
//

import Foundation
import RealmSwift
import Combine

protocol FavoriteLocalDataSource {
  func getFavoritePublisher() -> AnyPublisher<[FavoriteModel], Never>
  func isFavoritePublisher(gameId: Int) -> AnyPublisher<Bool, Never>
    func addFavorite(_ favorite: FavoriteModel, completion: @escaping (Result<Bool, Error>) -> Void)
      func deleteFavorite(gameId: Int, completion: @escaping (Result<Bool, Error>) -> Void)
}

class FavoriteLocalDataSourceImpl: FavoriteLocalDataSource {
  private let realm: Realm
  private var notificationToken: NotificationToken?
  private var favoriteSubject = CurrentValueSubject<[FavoriteModel], Never>([])

  init() {
    let config = Realm.Configuration(
           schemaVersion: 1,
           migrationBlock: { _, _ in }
       )
       Realm.Configuration.defaultConfiguration = config
       self.realm = try! Realm()
    
    observeFavorites()
  }

  deinit {
    notificationToken?.invalidate()
  }
  
  func getFavoritePublisher() -> AnyPublisher<[FavoriteModel], Never> {
    favoriteSubject.eraseToAnyPublisher()
  }
  
  func isFavoritePublisher(gameId: Int) -> AnyPublisher<Bool, Never> {
    let exist = realm.object(ofType: FavoriteModel.self, forPrimaryKey: gameId) != nil
    return Just(exist).eraseToAnyPublisher()
    
  }
  
  private func observeFavorites() {
    let favorites = realm.objects(FavoriteModel.self)
    notificationToken = favorites.observe { [weak self] changes in
      switch changes {
        case .initial(let results), .update(let results, _, _, _):
        self?.favoriteSubject.send(results.map(\.self))
      case .error(let error):
        print("Realm error: \(error.localizedDescription)")
      }
    }
  }
  
  func addFavorite(_ favorite: FavoriteModel, completion: @escaping (Result<Bool, any Error>) -> Void) {
    do {
      try realm.write {
        realm.add(favorite, update: .modified)
        completion(.success(true))
      }
    } catch {
      print("Error saving favorite: \(error.localizedDescription)")
      completion(.failure("\(error.localizedDescription)" as! Error))
    }
  }
  
  func deleteFavorite(gameId: Int, completion: @escaping (Result<Bool, any Error>) -> Void) {
    guard let objectToDelete = realm.object(ofType: FavoriteModel.self, forPrimaryKey: gameId) else {
      return
    }
    
    do {
      try realm.write {
        realm.delete(objectToDelete)
        completion(.success(true))
      }
    } catch {
      print("Error saving favorite: \(error.localizedDescription)")
      completion(.failure(error.localizedDescription as! Error))
    }
  }
  
}
