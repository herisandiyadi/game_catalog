//
//  FavoriteViewModel.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 11/07/25.
//

import Foundation
import RealmSwift

class FavoriteViewModel: ObservableObject {
    private var realm: Realm
    @Published private(set) var favorites: [FavoriteModel] = []
    private var notificationToken: NotificationToken?

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
            setupObserver()
        } catch {
            fatalError("Failed to initialize Realm: \(error.localizedDescription)")
        }
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    private func setupObserver() {
        let results = realm.objects(FavoriteModel.self)
        notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch changes {
                case .initial(let results), .update(let results, _, _, _):
                   
                    self.favorites = results.filter { !$0.isInvalidated }.map { $0.freeze() } 
                case .error(let error):
                    print("Error observing favorites: \(error)")
                }
            }
        }
    }

    func addFavorite(_ favorite: FavoriteModel) {
        do {
            try realm.write {
                realm.add(favorite, update: .modified)
            }
        } catch {
            print("Error saving favorite: \(error.localizedDescription)")
        }
    }

    func deleteFavorite(gameId: Int) {
        guard let objectToDelete = realm.object(ofType: FavoriteModel.self, forPrimaryKey: gameId) else {
            return
        }

        do {
            try realm.write {
                realm.delete(objectToDelete)
            }
        } catch {
            print("Error deleting favorite: \(error.localizedDescription)")
        }
    }

    func isFavorite(gameId: Int) -> Bool {
        return realm.object(ofType: FavoriteModel.self, forPrimaryKey: gameId) != nil
    }
}
