import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var viewModel: ProductViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(Array(viewModel.favorites), id: \._self) { product in
                    HStack {
                        AsyncImage(url: URL(string: product.image)) { phase in
                            if let image = phase.image {
                                image.resizable().scaledToFit()
                            } else {
                                Color.gray
                            }
                        }
                        .frame(width: 50, height: 50)
                        VStack(alignment: .leading) {
                            Text(product.title)
                            Text("$" + String(format: "%.2f", product.price))
                                .font(.subheadline)
                        }
                        Spacer()
                        Button(action: {
                            viewModel.toggleFavorite(product)
                        }) {
                            Image(systemName: "heart.slash")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
}
