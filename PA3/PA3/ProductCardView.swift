import SwiftUI

struct ProductCardView: View {
    @EnvironmentObject var appState: AppState
    let product: Product
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: product.image)) { image in
                image.resizable().aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(height: 100)
            Text(product.title)
                .font(.headline)
                .lineLimit(2)
                .multilineTextAlignment(.center)
            Text("$\(product.price, specifier: "%.2f")")
                .font(.subheadline)
            HStack {
                Button(action: { appState.toggleFavorite(product) }) {
                    Image(systemName: appState.favorites.contains(product) ? "heart.fill" : "heart")
                }
                Button(action: { appState.addToCart(product) }) {
                    Image(systemName: "cart")
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 8).stroke())
    }
}
