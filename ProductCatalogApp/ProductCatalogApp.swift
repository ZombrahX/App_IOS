import SwiftUI

@main
struct ProductCatalogApp: App {
    @StateObject private var viewModel = ProductViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
