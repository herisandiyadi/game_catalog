//
//  ContentView.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 06/07/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        NavigationStack{
            VStack {
                HStack {
                    Image("logo_rawg")
                        .frame(width: 80)
                        .padding(.horizontal, 24)
                    
                    Spacer()

                }
                .padding(.horizontal, 16)

                Spacer()
                
                if selectedTab == 0 {
                    HomeView()
                } else if selectedTab == 1 {
                    SearchView()
                } else {
                    ProfileView()
                }
                
                Spacer()
                
                HStack {
                    Button(action: { selectedTab = 0 }) {
                        VStack {
                            Image(systemName: "house.fill")
                            Text("Home")
                                .font(.caption)
                        }
                        .foregroundColor(selectedTab == 0 ? .white : .gray)
                        .padding()
                        .frame(maxWidth: .infinity)
                    }
                    
                    Button(action: { selectedTab = 1 }) {
                        VStack {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                                .font(.caption)
                        }
                        .foregroundColor(selectedTab == 1 ? .white : .gray)
                        .padding()
                        .frame(maxWidth: .infinity)
                    }
                    
                    Button(action: { selectedTab = 2 }) {
                        VStack {
                            Image(systemName: "person.fill")
                            Text("Profile")
                                .font(.caption)
                        }
                        .foregroundColor(selectedTab == 2 ? .white : .gray)
                        .padding()
                        .frame(maxWidth: .infinity)
                    }
                }
                .background(Color("GreyColor"))
                .clipShape(Capsule())
                .padding(.horizontal, 24)
          
                .shadow(radius: 5)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
                       .background(Color("BackgroundColor"))
                       
        }
        }
       
}

#Preview {
    ContentView()
}
