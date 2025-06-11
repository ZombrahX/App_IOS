import SwiftUI

struct CartView: View {
    @EnvironmentObject var state: AppState

    private var items: [(product: Product, qty: Int)] {
        state.cart.compactMap { (id, qty) in
            guard let product = state.products.first(where: { $0.id == id }) else { return nil }
            return (product, qty)
        }
        .sorted { $0.product.id < $1.product.id }
    }

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(items, id: \.product.id) { item in
                        CartRow(product: item.product)
                    }
                }
                totalBar
                payButton
            }
            .navigationTitle("Cart")
        }
    }

    private var totalBar: some View {
        HStack {
            Text("Total:")
            Spacer()
            Text("$\(state.totalAmount(), specifier: "%.2f")")
        }
        .padding()
    }

    private var payButton: some View {
        Button("Pagar ahora") {}
            .padding()
            .buttonStyle(.borderedProminent)
    }
}

struct CartRow: View {
    @EnvironmentObject var state: AppState
    let product: Product

    private func quantityBinding() -> Binding<Int> {
        Binding(
            get: { state.cart[product.id] ?? 1 },
            set: { state.updateQuantity(product: product, quantity: $0) }
        )
    }

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
            Stepper(value: quantityBinding(), in: 1...99) {
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
