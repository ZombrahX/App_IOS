import SwiftUI

struct HomeView: View {
    @EnvironmentObject var state: AppState

    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(state.products) { product in
                        ProductCardView(product: product)
                    }
                }
                .padding()
            }
            .navigationTitle("Home")
        }
        .task {
            if state.products.isEmpty {
                do {
                    state.products = try await ProductService.shared.fetchProducts()
                } catch {
                    print(error)
                }
            }
        }
    }
}

struct ProductCardView: View {
    @EnvironmentObject var state: AppState
    let product: Product

    var body: some View {
        VStack(alignment: .leading) {
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
            .frame(height: 100)

            Text(product.title)
                .font(.headline)
                .lineLimit(2)

            Text("$\(product.price, specifier: "%.2f")")
                .font(.subheadline)

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
        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
        .onTapGesture {
            state.detailSelection = product.id
        }
        .background(
            NavigationLink(destination: ProductDetailView(product: product), tag: product.id, selection: $state.detailSelection) {
                EmptyView()
            }
            .hidden()
        )
    }
}
