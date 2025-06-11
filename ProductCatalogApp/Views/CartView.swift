import SwiftUI

struct CartView: View {
    @EnvironmentObject var viewModel: ProductViewModel

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.cart) { item in
                        HStack {
                            AsyncImage(url: URL(string: item.product.image)) { phase in
                                if let image = phase.image {
                                    image.resizable().scaledToFit()
                                } else {
                                    Color.gray
                                }
                            }
                            .frame(width: 50, height: 50)
                            VStack(alignment: .leading) {
                                Text(item.product.title)
                                    .font(.headline)
                                Text("$" + String(format: "%.2f", item.product.price))
                                    .font(.subheadline)
                            }
                            Spacer()
                            HStack {
                                Button(action: {
                                    viewModel.decreaseQuantity(for: item)
                                }) {
                                    Image(systemName: "minus.circle")
                                }
                                Text("\(item.quantity)")
                                    .frame(width: 30)
                                Button(action: {
                                    viewModel.increaseQuantity(for: item)
                                }) {
                                    Image(systemName: "plus.circle")
                                }
                            }
                            Button(action: {
                                viewModel.removeFromCart(item)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                HStack {
                    Text("Total: ")
                    Spacer()
                    Text("$" + String(format: "%.2f", viewModel.totalPrice))
                        .bold()
                }
                .padding()
                Button(action: {}) {
                    Text("Pay Now")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Cart")
        }
    }
}
