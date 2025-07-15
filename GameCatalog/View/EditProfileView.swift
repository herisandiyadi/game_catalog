//
//  EditProfileView.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 14/07/25.
//

import AlertToast
import SwiftUI

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showPhotoOptions = false
    @State private var showImagePicker = false
    @State private var selectedSource: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage? = nil
    @State private var profileImagePath: String? = UserDefaults.standard.string(forKey: UserDefaultsKeys.imagePath)
       @State private var name: String = UserDefaults.standard.string(forKey: UserDefaultsKeys.displayName) ?? "Heri Sandiyadi"
       @State private var jobTitle: String = UserDefaults.standard.string(forKey: UserDefaultsKeys.userTitle) ?? "Mobile Developer"
       @State private var quote: String = UserDefaults.standard.string(forKey: UserDefaultsKeys.userQuotes) ?? "Di balik tampilan yang mulus, ada ribuan error yang sudah dikalahkan."
    @State private var showToast = false

    var body: some View {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        HStack{
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Text("Cancel")
                            }
                            Spacer()
                            
                        }.padding()
                        profileImageSection
                        profileTextFields
                        saveButton
                    }
                    .padding(.top, 40)
                }
                .toast(isPresenting: $showToast) {
                    AlertToast(type: .complete(.green), title: "Saved Successfully")
                }
            }
        }

        private var profileImageSection: some View {
            ZStack(alignment: .topTrailing) {
                displayedProfileImage()
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())

                editPhotoButton
                    .offset(x: -18, y: 18)
                    .confirmationDialog("Select Photo Source", isPresented: $showPhotoOptions) {
                        Button("Camera") { selectPhotoSource(.camera) }
                        Button("Photo Library") { selectPhotoSource(.photoLibrary) }
                        Button("Cancel", role: .cancel) {}
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(sourceType: selectedSource, selectedImage: $selectedImage)
                    }
            }
        }

        private var profileTextFields: some View {
            VStack(spacing: 12) {
                textField("Enter Name", text: $name, fontSize: 40, weight: .bold)
                textField("Enter Job Title", text: $jobTitle, fontSize: 30, weight: .light)
                TextEditor(text: $quote)
                    .frame(height: 60)
                    .font(.system(size: 16))
                    .foregroundColor(Color("GreyColor"))
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
            .padding()
        }

        private var saveButton: some View {
            Button(action: saveProfile) {
                Text("Save")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.blue)
                    )
                    .padding(.horizontal)
            }
        }

        // MARK: - Helper Functions

        private func displayedProfileImage() -> Image {
            if let selectedImage = selectedImage {
                return Image(uiImage: selectedImage)
            } else if let path = profileImagePath, let uiImage = UIImage(contentsOfFile: path) {
                return Image(uiImage: uiImage)
            } else {
                return Image("pict_profile")
            }
        }

        private var editPhotoButton: some View {
            Button {
                showPhotoOptions = true
            } label: {
                Circle()
                    .fill(Color.white)
                    .frame(width: 35, height: 35)
                    .overlay(
                        Image(systemName: "camera.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.blue)
                            .padding(4)
                    )
                    .overlay(
                        Circle()
                            .stroke(Color.blue, lineWidth: 2)
                    )
            }
        }

        private func textField(_ placeholder: String, text: Binding<String>, fontSize: CGFloat, weight: Font.Weight) -> some View {
            TextField(placeholder, text: text)
                .font(.system(size: fontSize, weight: weight, design: .rounded))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
        }

        private func selectPhotoSource(_ source: UIImagePickerController.SourceType) {
            selectedSource = source
            showImagePicker = true
        }

        private func saveProfile() {
            if let selectedImage = selectedImage,
               let path = saveImageToTemporaryDirectory(selectedImage) {
                UserDefaults.standard.set(path, forKey: UserDefaultsKeys.imagePath)
                profileImagePath = path
            }

            UserDefaults.standard.set(name, forKey: UserDefaultsKeys.displayName)
            UserDefaults.standard.set(jobTitle, forKey: UserDefaultsKeys.userTitle)
            UserDefaults.standard.set(quote, forKey: UserDefaultsKeys.userQuotes)

            showToast = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }

    #Preview {
        EditProfileView()
    }
