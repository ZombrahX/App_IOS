import Foundation

class ProductService {
    static let shared = ProductService()

    func fetchProducts() async throws -> [Product] {
        guard let url = URL(string: "https://sugary-wool-penguin.glitch.me/products") else {
            return []
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Product].self, from: data)
    }
}
