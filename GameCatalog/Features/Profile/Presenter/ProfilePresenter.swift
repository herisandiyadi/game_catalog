//
//  ProfilePresenter.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 24/07/25.
//

import SwiftUI

class ProfilePresenter: ObservableObject {
  private let useCase: ProfileUsecase
  private let router = ProfileRouter()
  
  @Published var profileImage: UIImage? = nil
  @Published var profileImagePath: String? = nil
  @Published var displayName: String = ""
  @Published var title: String = ""
  @Published var quotes: String = ""
  @Published var showToast: Bool = false

  
  init(useCase: ProfileUsecase) {
    self.useCase = useCase
    loadProfile()
  }
  
  func loadProfile() {
    let profile = useCase.getProfile()
    self.profileImagePath = profile.imagePath
    self.displayName = profile.name
    self.title = profile.title
    self.quotes = profile.quote
    
    if let path = profile.imagePath {
      self.profileImage = UIImage(contentsOfFile: path)
    }
  }
  
  func refreshProfileData() {
      let profile = useCase.getProfile()

      self.profileImagePath = profile.imagePath
      self.displayName = profile.name.isEmpty ? "Heri Sandiyadi" : profile.name
      self.title = profile.title.isEmpty ? "Mobile Developer" : profile.title
      self.quotes = profile.quote.isEmpty
          ? "Di balik tampilan yang mulus, ada ribuan error yang sudah dikalahkan."
          : profile.quote
      
      if let path = profile.imagePath {
          self.profileImage = UIImage(contentsOfFile: path)
      } else {
          self.profileImage = nil
      }
  }
  
  func saveProfileData(completion: @escaping () -> Void) {
    let profile = ProfileEntity(imagePath: profileImagePath,name: displayName, title: title, quote: quotes)
   
    
    profileImagePath = useCase.updateProfile(profile, image: profileImage)
    showToast = true
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
      completion()
    }
  }
  
  func linkBuilder<Content: View>(@ViewBuilder content: () -> Content) -> some View {
    NavigationLink(destination: router.routeTonEditProfile()) {
              content()
          }
      }
  
}
