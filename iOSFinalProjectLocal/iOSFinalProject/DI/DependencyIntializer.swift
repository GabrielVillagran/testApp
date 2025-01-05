
import Foundation

class DependencyInitializer {
    static let container = Container()
    
    init() {
        addDependencies(to: DependencyInitializer.container)
    }
    
    func addDependencies(to container: Container) {
        container.register(RootViewModel.self) { RootViewModel() }
        container.register(UserSessionListener.self) { RootViewModel()}
        container.register(PokemonService.self){
            PokemonMockService()
        }
        container.register(PokemonDisplayerViewModel.self) {
            guard let pokemonService = DependencyInitializer.container.resolve(PokemonService.self) else {
                fatalError("Pokemon Service not provided")
            }
            return PokemonDisplayerViewModel()
        }
        container.register(CreateAccountViewModel.self) {
            CreateAccountViewModel()
        }
    }
}
