import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(appState.products) { product in
                        NavigationLink(value: product) {
                            ProductCardView(product: product)
                        }
                    }
                }
                .padding()
            }
            .navigationDestination(for: Product.self) { product in
                ProductDetailView(product: product)
            }
            .task {
                await appState.loadProducts()
            }
            .navigationTitle("Home")
        }
    }
}
