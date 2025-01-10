//
//  PokemonDetailsServices.swift
//  iOSFinalProject
//
//  Created by Trainee on 1/9/25.
//

import Foundation

protocol PokemonDetailsService {
    func fetchPokemonDetails(at id: Int?) async throws -> DisplayablePokemon
}

class PokemonDetailsMockServiceImpl: PokemonDetailsService {

    private let session: URLSession = URLSession.shared
    private let decoder: JSONDecoder = JSONDecoder()

    func fetchPokemonDetails(at id: Int?) async throws -> DisplayablePokemon {
        guard let id else { throw Errors.invalidURL }
        guard let url = URL(
            string: "https://hola1-ak17.onrender.com/getPokemon?id=\(id)"
        )
        else {
            throw(Errors.invalidURL)
        }
        do {
            let (data, _) = try await session.data(from: url)
            let pokemonInfo = try decoder.decode(PokemonDetailsResponse.self, from: data)
            return pokemonInfo.data
        } catch {
            throw(Errors.invalidResponse)
        }
    }
}
