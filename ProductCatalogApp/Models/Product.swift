import Foundation

struct Rating: Codable {
    let rate: Double
    let count: Int
}

struct Product: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
}

struct CartItem: Identifiable {
    let id: Int
    var product: Product
    var quantity: Int
}
