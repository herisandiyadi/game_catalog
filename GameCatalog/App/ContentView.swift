//
//  ContentView.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 06/07/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
  @StateObject private var presenter: FavoritePresenter = DIContainer.shared.resolve(FavoritePresenter.self)

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                headerView
                Spacer()
                contentView
                Spacer()
                tabBar
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BackgroundColor"))
        }
    }

    private var headerView: some View {
        HStack {
            Image("logo_rawg")
                .resizable()
                .frame(width: 80, height: 40)
                .padding(.horizontal, 24)
            Spacer()
        }
        .padding(.horizontal, 16)
    }

    @ViewBuilder
    private var contentView: some View {
        switch selectedTab {
        case 0: HomeView()
        case 1: SearchView()
        case 2: FavoriteView()
        case 3: ProfileView()
        default: HomeView()
        }
    }

    private var tabBar: some View {
        HStack {
            tabBarItem(icon: "house.fill", label: "Home", index: 0)
            tabBarItem(icon: "magnifyingglass", label: "Search", index: 1)
            tabBarItem(icon: "heart.fill", label: "Favorite", index: 2)
            tabBarItem(icon: "person.fill", label: "Profile", index: 3)
        }
        .background(Color("GreyColor"))
        .clipShape(Capsule())
        .padding(.horizontal, 24)
        .shadow(radius: 5)
    }

    private func tabBarItem(icon: String, label: String, index: Int) -> some View {
        Button(action: { selectedTab = index }) {
            VStack {
                Image(systemName: icon)
                Text(label)
                    .font(.caption)
            }
            .foregroundColor(selectedTab == index ? .white : .gray)
            .padding()
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    ContentView()

}
