//
//  PokemonDetailsViewModel.swift
//  iOSFinalProject
//
//  Created by Trainee on 1/9/25.
//

import Foundation
import UIKit

class PokemonDetailsViewModel: ObservableObject {
    
    let pokemonDetailsService: PokemonDetailsService
    let pokemonImageService: PokemonImageService
    
    //@Published var pokemon: DisplayablePokemon?
    
    @Published var pokemonState: PokemonDetailsViewState = .loading
    @Published var imageState: ImageViewState = .loading
    private var isLoading = false
    
    

    init() {
        @Inject
        var _pokemonDetailsService: PokemonDetailsService
        self.pokemonDetailsService = _pokemonDetailsService
        @Inject
        var _pokemonImageService: PokemonImageService
        self.pokemonImageService = _pokemonImageService
    }

    func initialize(id: Int? = 1) {
        if isLoading {
            return
        }
        isLoading = true
        pokemonState = .loading
        Task {
            do {
                let pokemonResponse = try await pokemonDetailsService.fetchPokemonDetails(at: id)

                await onPokemonInfoFetched(pokemon: pokemonResponse)
                
            } catch is Errors {
                pokemonState = .error("Oops Something went wrong")
            }
        }
    }

    @MainActor
    private func onPokemonInfoFetched(pokemon: DisplayablePokemon) {
        pokemonState = .success(pokemon)
        isLoading = false
    }

    func fetchMovieImage(url: URL) {
        imageState = .loading
        Task {
            do {
                let image = try await pokemonImageService.loadPokemonImage(from: url)
                await MainActor.run { imageState = .success(image)}
            } catch is Errors {
                imageState = .error("Oops Something went wrong with the image")
            }
        }
    }
}

enum PokemonDetailsViewState: Codable {
    case loading
    case error(String)
    case success(DisplayablePokemon)
}

enum ImageViewState {
    case loading
    case error(String)
    case success(UIImage)
}

