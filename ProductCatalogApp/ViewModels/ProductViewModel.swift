import Foundation
import Combine

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var favorites: Set<Product> = []
    @Published var cart: [CartItem] = []
    @Published var selectedProduct: Product?

    private var cancellables = Set<AnyCancellable>()
    private let url = URL(string: "https://sugary-wool-penguin.glitch.me/products")!

    init() {
        fetchProducts()
    }

    func fetchProducts() {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Product].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.products = items
            }
            .store(in: &cancellables)
    }

    func toggleFavorite(_ product: Product) {
        if favorites.contains(product) {
            favorites.remove(product)
        } else {
            favorites.insert(product)
        }
    }

    func addToCart(_ product: Product) {
        if let index = cart.firstIndex(where: { $0.id == product.id }) {
            cart[index].quantity += 1
        } else {
            cart.append(CartItem(id: product.id, product: product, quantity: 1))
        }
    }

    func removeFromCart(_ item: CartItem) {
        cart.removeAll { $0.id == item.id }
    }

    func increaseQuantity(for item: CartItem) {
        if let index = cart.firstIndex(where: { $0.id == item.id }) {
            cart[index].quantity += 1
        }
    }

    func decreaseQuantity(for item: CartItem) {
        if let index = cart.firstIndex(where: { $0.id == item.id }) {
            cart[index].quantity = max(1, cart[index].quantity - 1)
        }
    }

    var totalPrice: Double {
        cart.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
}
