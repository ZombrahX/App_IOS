import SwiftUI

struct ContentView: View {
    @StateObject private var state = AppState()

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
        }
        .environmentObject(state)
    }
}

#Preview {
    ContentView()
}
