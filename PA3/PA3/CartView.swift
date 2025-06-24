import SwiftUI

struct CartView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(appState.cart) { item in
                    HStack {
                        AsyncImage(url: URL(string: item.product.image)) { image in
                            image.resizable().aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 60, height: 60)
                        VStack(alignment: .leading) {
                            Text(item.product.title)
                                .font(.headline)
                            Text("$\(item.product.price, specifier: "%.2f")")
                        }
                        Spacer()
                        Stepper {
                            Text("Qty: \(item.quantity)")
                        } onIncrement: {
                            appState.updateQuantity(for: item, delta: 1)
                        } onDecrement: {
                            appState.updateQuantity(for: item, delta: -1)
                        }
                        Button(action: { appState.removeFromCart(item) }) {
                            Image(systemName: "trash")
                        }
                    }
                }
            }
            VStack {
                Text("Total: $\(appState.totalPrice, specifier: "%.2f")")
                    .font(.title2)
                Button("Pagar ahora") {}
                    .buttonStyle(.borderedProminent)
                    .padding()
            }
            .navigationTitle("Cart")
        }
    }
}
