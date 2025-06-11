import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var viewModel: ProductViewModel
    let product: Product

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: product.image)) { phase in
                    if let image = phase.image {
                        image.resizable().scaledToFit()
                    } else {
                        ProgressView()
                    }
                }
                Text(product.title)
                    .font(.title)
                Text("$" + String(format: "%.2f", product.price))
                    .font(.title2)
                Text(product.description)
                HStack {
                    Text("Category: \(product.category)")
                    Spacer()
                    Text("Rating: \(product.rating.rate, specifier: "%.1f") (
                        product.rating.count)")
                }
                HStack {
                    Button(action: {
                        viewModel.toggleFavorite(product)
                    }) {
                        Image(systemName: viewModel.favorites.contains(product) ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                    }
                    Spacer()
                    Button(action: {
                        viewModel.addToCart(product)
                    }) {
                        Image(systemName: "cart.badge.plus")
                    }
                }
                .padding(.top)
            }
            .padding()
        }
    }
}
