//
//  ProfileView.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 06/07/25.
//


import SwiftUI

struct ProfileView: View {
  @Environment(\.presentationMode) var presentationMode
  @State private var showEditProfile = false
  @StateObject private var presenter: ProfilePresenter = DIContainer.shared.resolve(ProfilePresenter.self)
  
  var body: some View {
    ScrollView {
      headerSection
      profileContent
        .padding(.top, 40)
    }
    .onAppear {
      presenter.refreshProfileData()
    }
    .sheet(isPresented: $showEditProfile) {
      EditProfileView()
    }
  }
  
  private var headerSection: some View {
    HStack {
      Spacer()
      Button("Edit Profile") {
        showEditProfile = true
      }
      .font(.system(size: 12, weight: .medium, design: .rounded))
      .foregroundColor(.blue)
      .padding()
    }
  }
  
  private var profileContent: some View {
    VStack {
      profileImage
      VStack(spacing: 8) {
        Text(presenter.displayName)
          .font(.system(size: 40, weight: .bold, design: .rounded))
          .foregroundColor(.white)
          .padding(.top, 36)
        
        Text(presenter.title)
          .font(.system(size: 30, weight: .light, design: .rounded))
          .foregroundColor(.white)
        
        Text("“\(presenter.quotes)”")
          .font(.system(size: 16, weight: .regular, design: .rounded))
          .italic()
          .foregroundColor(.white)
          .padding(4)
      }
    }
  }
  
  private var profileImage: some View {
    Group {
      if let path = presenter.profileImagePath, let uiImage = UIImage(contentsOfFile: path) {
        Image(uiImage: uiImage)
          .resizable()
      } else {
        Image("pict_profile")
          .resizable()
      }
    }
    .scaledToFill()
    .frame(width: 200, height: 200)
    .clipShape(Circle())
    .background(Circle().fill(Color.gray.opacity(0.2)))
    .overlay(
      Circle()
        .stroke(Color.gray, lineWidth: 2)
    )
  }
}

    #Preview {
        ProfileView()
    }
