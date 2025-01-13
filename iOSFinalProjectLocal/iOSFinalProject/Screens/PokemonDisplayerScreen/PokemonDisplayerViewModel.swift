import Foundation
import UIKit

class PokemonDisplayerViewModel {

    var service: PokemonService
    @Published var pokemonState: PokemonDetailsState = .loading

    init() {
        @Inject
        var _service: PokemonService
        self.service = _service
    }
    
    func initialize() {
        pokemonState = .loading
        Task {

            do {
                let responseViews = try await service.fetchPokemon()
                let characters = responseViews.data
                if let characters {
                    let transformedCharacterList = transformPokemonData(from: characters)
                    await getCharacterList(character: transformedCharacterList)
                } else {
                    pokemonState = .error("404 Not Found")
                }
            }
        }
    }

    func transformPokemonData(from pokemons: [Pokemon]) -> [DisplayablePokemon] {
        let pokemon: [DisplayablePokemon] = pokemons.compactMap { member in
            guard let id = member.id, let name = member.name, let abilities = member.abilities, let types = member.types,
                  let image = member.image, let height = member.height, let weight = member.weight else { return nil }
            return DisplayablePokemon(id: id, name: name, abilities: abilities, types: types, image: image, height: height, weight: weight)
        }
        return pokemon
    }

    @MainActor
    private func getCharacterList(character: [DisplayablePokemon]) {
        pokemonState = .success(character)
    }
}

enum PokemonDetailsState: Codable {
    //case none
    case loading
    case error(String)
    case success([DisplayablePokemon])
}
