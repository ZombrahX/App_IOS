import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var appState: AppState
    let product: Product
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: product.image)) { image in
                    image.resizable().aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 200)
                Text(product.title)
                    .font(.title)
                    .bold()
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.title3)
                Text(product.description)
                HStack {
                    Text("Category: \(product.category)")
                    Spacer()
                    Text("Rating: \(product.rating.rate, specifier: "%.1f")")
                }
                HStack {
                    Button(action: { appState.toggleFavorite(product) }) {
                        Label("Favorite", systemImage: appState.favorites.contains(product) ? "heart.fill" : "heart")
                    }
                    Spacer()
                    Button(action: { appState.addToCart(product) }) {
                        Label("Add to Cart", systemImage: "cart")
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Detail")
    }
}
