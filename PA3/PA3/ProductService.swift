import Foundation

class ProductService {
    func fetchProducts() async throws -> [Product] {
        guard let url = URL(string: "https://sugary-wool-penguin.glitch.me/products") else {
            return []
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode([Product].self, from: data)
    }
}
