# GameCatalog

GameCatalog is an iOS application that allows users to explore, search, and view details of popular games. Built with Swift and SwiftUI, the app leverages the MVVM architecture for clean code separation and maintainability.

## Features

- **Home Screen:** Browse a curated list of popular games with visually appealing cards.
- **Game Search:** Search for games by name with instant results.
- **Game Details:** View comprehensive information for each game, including images, descriptions, and supported platforms.
- **Favorite Games:** Mark and manage your favorite games for quick access.
- **Profile Page:** Simple user profile display and profile editing, including profile picture selection.
- **Edit Profile:** Update user profile information and profile picture using a custom image picker.
- **Platform Support:** Visual indicators for platforms (PlayStation, Xbox, Nintendo, Windows, etc.) for each game.
- **Placeholder & Error Handling:** Displays placeholder images when game images are unavailable.
- **Modern UI:** Consistent color palette and iconography for a pleasant user experience.
- **Custom Widgets:** Reusable UI components such as custom cards, search bar, favorite button, and HTML text rendering.
- **Persistent Storage:** User preferences and favorites are stored using UserDefaults.

## Tech Stack

- **Language:** Swift
- **UI Framework:** SwiftUI
- **Architecture:** MVVM (Model-View-ViewModel) with Helper and Widget layers
- **IDE:** Xcode
- **Asset Management:** Asset Catalogs (.xcassets)
- **Linting:** SwiftLint (`.swiftlint.yml`)
- **Testing:** XCTest (unit and UI tests)
- **API:** (Optional) RAWG Video Games Database API (logo present in assets, integration assumed)

## Architecture

The project follows the MVVM (Model-View-ViewModel) architecture, enhanced with Service, Helper, and Widget layers for better modularity and code reuse:

- **Model:** Data structures representing games, favorites, and search results.
- **View:** SwiftUI views for UI screens (Home, Search, Detail, Profile, Edit Profile, Favorite).
- **ViewModel:** Handles business logic, data fetching, and state management for each view.
- **Service:** Abstractions for data fetching and API communication (e.g., ProductServiceProtocol).
- **Widget:** Custom reusable UI components (e.g., CustomCardView, SearchBarView, FavoriteButton, HTMLTextView).
- **Helper:** Utility classes for tasks like image picking and persistent storage (e.g., ImagePicker, UserDefaultHelper).

## Project Structure

```
GameCatalog/
├── Assets.xcassets/         # Image and color assets
├── Model/                   # Data models (ProductModel, DetailProductModel, SearchProductModel, FavoriteModel)
├── Services/                # Service layer for API abstraction (ProductServiceProtocol, etc.)
├── View/                    # Main views (HomeView, SearchView, DetailGameView, ProfileView, EditProfileView, FavoriteView)
│   └── widget/              # Custom UI components (CustomCardView, SearchBarView, FavoriteButton, HTMLTextView, etc.)
├── ViewModel/               # ViewModels for data and business logic (ProductViewModel, SearchViewModel, FavoriteViewModel)
├── Helper/                  # Utility classes (ImagePicker, UserDefaultHelper, UserDefaultKeys)
├── ContentView.swift        # App entry point
├── GameCatalogApp.swift     # Main app configuration
├── Info.plist               # iOS app configuration
```

## Getting Started

1. Ensure you have the latest version of Xcode installed.
2. Clone this repository:
   ```
   git clone https://github.com/herisandiyadi/game_catalog.git
   ```
3. Open `GameCatalog.xcodeproj` in Xcode.
4. Build and run the app on a simulator or physical iOS device.

## Contribution

Contributions are welcome! Please fork this repository and submit a pull request for new features or bug fixes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
