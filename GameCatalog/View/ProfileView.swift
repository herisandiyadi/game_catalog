//
//  ProfileView.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 06/05/25.
//


import SwiftUI
struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack {
                Circle()
                    .fill(Color.gray.opacity(0.2))
                    .overlay(
                        Image("pict_profile")
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                    )
                    .frame(width: 200, height: 200)
                    .padding(5)
                    .overlay(
                        Circle()
                            .stroke(Color.gray, lineWidth: 2)
                    )
                
                VStack{
                    Text("Heri Sandiyadi")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.top, 36)
                    
                    Text("Mobile Developer")
                        .font(.system(size: 30, weight: .light, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text("“Di balik tampilan yang mulus, ada ribuan error yang sudah dikalahkan.”")
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .italic()
                        .foregroundColor(.white)
                        .padding(4)
                }
            }
            .padding(.top, 40)
        }.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
            )
    }
}

#Preview {
    ProfileView()
}
