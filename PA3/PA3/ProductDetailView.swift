import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var state: AppState
    let product: Product

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: product.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable().scaledToFit()
                    case .failure:
                        Image(systemName: "photo")
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(height: 200)

                Text(product.title)
                    .font(.title)
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.title3)
                Text(product.description)
                    .font(.body)
                Text("Category: \(product.category)")
                    .font(.footnote)
                if let rating = product.rating {
                    Text("Rating: \(rating.rate, specifier: "%.1f") (\(rating.count))")
                        .font(.footnote)
                }
                HStack {
                    Button(action: {
                        state.toggleFavorite(product: product)
                    }) {
                        Image(systemName: state.favorites.contains(product.id) ? "heart.fill" : "heart")
                    }
                    Button(action: {
                        state.addToCart(product: product)
                    }) {
                        Image(systemName: "cart")
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Detail")
    }
}
