import Foundation
import Combine

class AppState: ObservableObject {
    @Published var products: [Product] = []
    @Published var detailSelection: Int?

    @Published var favorites: Set<Int> = [] {
        didSet { saveFavorites() }
    }
    @Published var cart: [Int: Int] = [:] { // productId -> quantity
        didSet { saveCart() }
    }

    private let favoritesKey = "favorites"
    private let cartKey = "cart"

    init() {
        loadFavorites()
        loadCart()
    }

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

    private func loadFavorites() {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey),
              let set = try? JSONDecoder().decode(Set<Int>.self, from: data) else {
            return
        }
        favorites = set
    }

    private func saveFavorites() {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: favoritesKey)
        }
    }

    private func loadCart() {
        guard let data = UserDefaults.standard.data(forKey: cartKey),
              let dict = try? JSONDecoder().decode([Int: Int].self, from: data) else {
            return
        }
        cart = dict
    }

    private func saveCart() {
        if let data = try? JSONEncoder().encode(cart) {
            UserDefaults.standard.set(data, forKey: cartKey)
        }
    }
}
