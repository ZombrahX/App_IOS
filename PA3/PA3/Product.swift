import Foundation

struct Rating: Codable {
    let rate: Double
    let count: Int
}

struct Product: Identifiable, Codable, Equatable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
}

struct CartItem: Identifiable, Equatable {
    let id = UUID()
    let product: Product
    var quantity: Int
}
