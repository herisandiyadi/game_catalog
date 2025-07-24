//
//  ProfileInteractor.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 24/07/25.
//

import Foundation
import UIKit

protocol ProfileUsecase {
  func getProfile() -> ProfileEntity
  func updateProfile(_ profile: ProfileEntity, image: UIImage?) -> String?
}

class ProfileInteractor: ProfileUsecase {
  private let userDefaults = UserDefaults.standard
  
  func getProfile() -> ProfileEntity {
    return ProfileEntity(
      imagePath: UserDefaults.standard.string(forKey: UserDefaultsKeys.imagePath),
      name: UserDefaults.standard.string(forKey: UserDefaultsKeys.displayName) ?? "Heri Sandiyadi",
      title: UserDefaults.standard.string(forKey: UserDefaultsKeys.userTitle) ?? "Mobile Developer",
      quote: UserDefaults.standard.string(forKey: UserDefaultsKeys.userQuotes) ?? "Di balik tampilan yang mulus, ada ribuan error yang sudah dikalahkan."
    )
  
  }
  
  func updateProfile(_ profile: ProfileEntity, image: UIImage?) -> String? {
    var path: String? = profile.imagePath
    
    if let image = image, let saved = saveImageToTemporaryDirectory(image) {
      UserDefaults.standard.set(saved, forKey: UserDefaultsKeys.imagePath)
      path = saved
    }
    
    UserDefaults.standard.set(profile.name, forKey: UserDefaultsKeys.displayName)
            UserDefaults.standard.set(profile.title, forKey: UserDefaultsKeys.userTitle)
            UserDefaults.standard.set(profile.quote, forKey: UserDefaultsKeys.userQuotes)
            
            return path
  }
  
}


