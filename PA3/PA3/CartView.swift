import SwiftUI

struct CartView: View {
    @EnvironmentObject var state: AppState

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(state.cart.keys.sorted(), id: .self) { id in
                        if let product = state.products.first(where: { $0.id == id }) {
                            CartRow(product: product)
                        }
                    }
                }
                HStack {
                    Text("Total: $")
                    Spacer()
                    Text("$\(state.totalAmount(), specifier: "%.2f")")
                }
                .padding()
                Button("Pagar ahora") {}
                    .padding()
                    .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Cart")
        }
    }
}

struct CartRow: View {
    @EnvironmentObject var state: AppState
    let product: Product

    var body: some View {
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
            Stepper(value: Binding(
                get: { state.cart[product.id] ?? 1 },
                set: { state.updateQuantity(product: product, quantity: $0) }
            ), in: 1...99) {
                Text("\(state.cart[product.id] ?? 1)")
            }
            Button(action: {
                state.removeFromCart(product: product)
            }) {
                Image(systemName: "trash")
            }
        }
    }
}
