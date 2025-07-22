//
//  FavoriteLocalDataSource.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 22/07/25.
//

import Foundation
import RealmSwift

protocol FavoriteLocalDataSource {
      func observeFavorites(changeHandler: @escaping (Result<[FavoriteModel], Error>) -> Void) -> NotificationToken?
      func addFavorite(_ favorite: FavoriteModel, completion: @escaping (Result<Bool, Error>) -> Void)
      func deleteFavorite(gameId: Int, completion: @escaping (Result<Bool, Error>) -> Void)
      func isFavorite(gameId: Int) -> Bool
}

class FavoriteLocalDataSourceImpl: FavoriteLocalDataSource {
  private var realm: Realm

  init() {
    do {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                }
            }
        )
        Realm.Configuration.defaultConfiguration = config
        realm = try Realm()
    } catch {
        fatalError("Failed to initialize Realm: \(error.localizedDescription)")
    }
  }
  
  deinit {
    
  }
  
  func observeFavorites(changeHandler: @escaping (Result<[FavoriteModel], Error>) -> Void) -> NotificationToken? {
          let results = realm.objects(FavoriteModel.self)
          let token = results.observe { changes in
              DispatchQueue.main.async {
                  switch changes {
                  case .initial(let results), .update(let results, _, _, _):
                    let favorites = Array(results.filter { !$0.isInvalidated }.map { $0.freeze() })
                    changeHandler(.success(favorites))
                  case .error(let error):
                      changeHandler(.failure(error))
                  }
              }
          }
          return token
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
  
  func isFavorite(gameId: Int) -> Bool {
      return realm.object(ofType: FavoriteModel.self, forPrimaryKey: gameId) != nil
  }

  
}
