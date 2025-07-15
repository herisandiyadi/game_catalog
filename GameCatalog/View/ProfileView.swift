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
      @State private var profileImagePath: String? = UserDefaults.standard.string(forKey: UserDefaultsKeys.imagePath)
      @State private var displayName: String = UserDefaults.standard.string(forKey: UserDefaultsKeys.displayName) ?? "Heri Sandiyadi"
      @State private var title: String = UserDefaults.standard.string(forKey: UserDefaultsKeys.userTitle) ?? "Mobile Developer"
      @State private var quotes: String = UserDefaults.standard.string(forKey: UserDefaultsKeys.userQuotes) ?? "Di balik tampilan yang mulus, ada ribuan error yang sudah dikalahkan."

    var body: some View {
            ScrollView {
                headerSection
                profileContent
                    .padding(.top, 40)
            }
            .onAppear {
                refreshProfileData()
            }
            .sheet(isPresented: $showEditProfile, onDismiss: refreshProfileData) {
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
                    Text(displayName)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.top, 36)

                    Text(title)
                        .font(.system(size: 30, weight: .light, design: .rounded))
                        .foregroundColor(.white)

                    Text("“\(quotes)”")
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .italic()
                        .foregroundColor(.white)
                        .padding(4)
                }
            }
        }

        private var profileImage: some View {
            Group {
                if let path = profileImagePath, let uiImage = UIImage(contentsOfFile: path) {
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

        private func refreshProfileData() {
            profileImagePath = UserDefaults.standard.string(forKey: UserDefaultsKeys.imagePath)
            displayName = UserDefaults.standard.string(forKey: UserDefaultsKeys.displayName) ?? "Heri Sandiyadi"
            title = UserDefaults.standard.string(forKey: UserDefaultsKeys.userTitle) ?? "Mobile Developer"
            quotes = UserDefaults.standard.string(forKey: UserDefaultsKeys.userQuotes) ?? "Di balik tampilan yang mulus, ada ribuan error yang sudah dikalahkan."
        }
    }

    #Preview {
        ProfileView()
    }
