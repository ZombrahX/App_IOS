import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(appState.favorites) { product in
                    HStack {
                        AsyncImage(url: URL(string: product.image)) { image in
                            image.resizable().aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 60, height: 60)
                        VStack(alignment: .leading) {
                            Text(product.title)
                                .font(.headline)
                            Text("$\(product.price, specifier: "%.2f")")
                                .font(.subheadline)
                        }
                        Spacer()
                        Button(action: { appState.toggleFavorite(product) }) {
                            Image(systemName: "trash")
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
}
