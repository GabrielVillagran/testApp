//
//  PokemonDetailsMockService.swift
//  iOSFinalProject
//
//  Created by Trainee on 1/10/25.
//

import Foundation

class PokemonDetailsMockServiceImpl: PokemonDetailsService {
    
    func fetchPokemonDetails(at id: Int?) async throws -> DisplayablePokemon {
        return DisplayablePokemon(id: 1, name: "bulbasaur" ,abilities: [
            "overgrow",
            "chlorophyll"], types: ["grass",
                                    "poison"], image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", height: 7, weight: 69)
    }
}
