import Foundation
@testable import iOSFinalProject

class MockPokemonTestService: PokemonService {
    var failResponse = false
    func fetchPokemon() async throws -> iOSFinalProject.PokemonResponse {
        if !failResponse {
            return PokemonResponse(data: [Pokemon(id: 1, name: "Bulbasur", abilities: ["1","2"], types: ["fire","water"], image: "http:url", height: 5.7, weight: 90.89)])
        }
        else {
            throw Errors.invalidURL
        }
    }
}


enum Errors: Error {
    case invalidURL
    case invalidResponse
}
