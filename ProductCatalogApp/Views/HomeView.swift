import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: ProductViewModel
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.products) { product in
                        ProductCard(product: product)
                    }
                }
                .padding()
            }
            .navigationTitle("Products")
        }
    }
}

struct ProductCard: View {
    @EnvironmentObject var viewModel: ProductViewModel
    let product: Product

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: product.image)) { phase in
                if let image = phase.image {
                    image.resizable().scaledToFit()
                } else if phase.error != nil {
                    Color.red
                } else {
                    ProgressView()
                }
            }
            .frame(height: 120)
            Text(product.title)
                .font(.headline)
                .lineLimit(2)
            Text("$" + String(format: "%.2f", product.price))
                .font(.subheadline)
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
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(8)
        .onTapGesture {
            viewModel.selectedProduct = product
        }
        .sheet(item: $viewModel.selectedProduct) { prod in
            ProductDetailView(product: prod)
        }
    }
}
