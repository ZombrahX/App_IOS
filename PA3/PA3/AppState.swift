import Foundation
import Combine

class AppState: ObservableObject {
    @Published var products: [Product] = []
    @Published var detailSelection: Int?

    @Published var favorites: Set<Int> = []
    @Published var cart: [Int: Int] = [:] // productId -> quantity

    func toggleFavorite(product: Product) {
        if favorites.contains(product.id) {
            favorites.remove(product.id)
        } else {
            favorites.insert(product.id)
        }
    }

    func addToCart(product: Product) {
        cart[product.id, default: 0] += 1
    }

    func removeFromCart(product: Product) {
        cart[product.id] = nil
    }

    func updateQuantity(product: Product, quantity: Int) {
        if quantity <= 0 {
            cart[product.id] = nil
        } else {
            cart[product.id] = quantity
        }
    }

    func totalAmount() -> Double {
        var total = 0.0
        for (id, qty) in cart {
            if let product = products.first(where: { $0.id == id }) {
                total += product.price * Double(qty)
            }
        }
        return total
    }
}
