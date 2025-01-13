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

class PokemonDetailsServiceImpl: PokemonDetailsService {
    
    private let session: URLSession = URLSession.shared
    private let decoder: JSONDecoder = JSONDecoder()
    
    func fetchPokemonDetails(at id: Int?) async throws -> DisplayablePokemon {
        guard let id, let url = URL(
            string: "\(DetailsScreenServiceConstants.baseURL.rawValue)getPokemon?id=\(id)"
        ) else { throw Errors.invalidURL }
        do {
            print(url)
            let (data, _) = try await session.data(from: url)
            let pokemonInfo = try decoder.decode(PokemonDetailsResponse.self, from: data)
            return pokemonInfo.data
        } catch {
            throw(Errors.invalidResponse)
        }
    }
}
