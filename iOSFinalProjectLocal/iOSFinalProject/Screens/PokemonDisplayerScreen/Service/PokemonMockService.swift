import Foundation



enum Errors: Error {
    case invalidURL
    case invalidResponse
}

struct PokemonMockService: PokemonService {
    func fetchPokemon(page: Int) async throws -> PokemonResponse {
        var sampleItems: [Pokemon] {
            (1...10).map { index in
                Pokemon(
                    id: index,
                    name: "Pokemon \(index)",
                    abilities: [],
                    types: [],
                    image: "PokemonImageUrl \(index)",
                    height: Float(index),
                    weight: Float(index)
                )
            }
        }
        return PokemonResponse(data: sampleItems)
    }
}
