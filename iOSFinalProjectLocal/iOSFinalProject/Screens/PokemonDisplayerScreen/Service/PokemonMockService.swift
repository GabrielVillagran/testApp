//
//  PokemonMockService.swift
//  iOSFinalProject
//
//  Created by GenericDevCalifornia on 1/3/25.
//

import Foundation

protocol PokemonService {
    func fetchPokemon() async throws -> PokemonResponse
}

enum Errors: Error {
    case invalidURL
    case invalidResponse
}

struct PokemonMockService: PokemonService {
    func fetchPokemon() async throws -> PokemonResponse {
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
