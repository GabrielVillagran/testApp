//
//  PokemonDetailsServices.swift
//  iOSFinalProject
//
//  Created by Trainee on 1/9/25.
//

import Foundation

protocol PokemonService {
    func fetchPokemon() async throws -> PokemonResponse
}

class PokemonServiceImpl: PokemonService {
    private let session: URLSession = URLSession.shared
    private let decoder: JSONDecoder = JSONDecoder()
    
    func fetchPokemon() async throws -> PokemonResponse {
        guard let url = URL(
            string: "https://finalprojectpublic.onrender.com/getPokemonPage?page=1"
        ) else { throw Errors.invalidURL }
        do {
            let (data, _) = try await session.data(from: url)
            let pokemonInfo = try decoder.decode(PokemonResponse.self, from: data)
            return pokemonInfo
        } catch {
            throw(Errors.invalidResponse)
        }
    }
}

