import SwiftUI

@MainActor
class AppState: ObservableObject {
    @Published var products: [Product] = []
    @Published var favorites: [Product] = []
    @Published var cart: [CartItem] = []
    
    private let service = ProductService()
    
    func loadProducts() async {
        do {
            products = try await service.fetchProducts()
        } catch {
            print("Failed to load products: \(error)")
        }
    }
    
    func toggleFavorite(_ product: Product) {
        if let index = favorites.firstIndex(of: product) {
            favorites.remove(at: index)
        } else {
            favorites.append(product)
        }
    }
    
    func addToCart(_ product: Product) {
        if let index = cart.firstIndex(where: { $0.product.id == product.id }) {
            cart[index].quantity += 1
        } else {
            cart.append(CartItem(product: product, quantity: 1))
        }
    }
    
    func removeFromCart(_ item: CartItem) {
        cart.removeAll { $0.id == item.id }
    }
    
    func updateQuantity(for item: CartItem, delta: Int) {
        guard let index = cart.firstIndex(where: { $0.id == item.id }) else { return }
        cart[index].quantity = max(1, cart[index].quantity + delta)
    }
    
    var totalPrice: Double {
        cart.reduce(0) { $0 + Double($1.quantity) * $1.product.price }
    }
}
