import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var state: AppState

    var body: some View {
        NavigationView {
            List {
                ForEach(state.products.filter { state.favorites.contains($0.id) }) { product in
                    HStack {
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
                        .frame(width: 60, height: 60)

                        VStack(alignment: .leading) {
                            Text(product.title)
                                .font(.headline)
                            Text("$\(product.price, specifier: "%.2f")")
                                .font(.subheadline)
                        }
                        Spacer()
                        Button(action: {
                            state.toggleFavorite(product: product)
                        }) {
                            Image(systemName: "trash")
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Favorites")
        }
    }
}
