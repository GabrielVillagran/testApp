import Foundation

struct Pokemon: Codable {
    let id: Int?
    let name: String?
    let abilities: [String]?
    let types: [String]?
    let image: String?
    let height: Float?
    let weight: Float?
}
