import Foundation

class DependencyInitializer {
    static let container = Container()
    
    init() {
        addDependencies(to: DependencyInitializer.container)
    }
    
    func addDependencies(to container: Container) {
        container.register(RootViewModel.self) { RootViewModel() }
        container.register(UserSessionListener.self) { RootViewModel()}
        container.register(PokemonService.self) {
            PokemonServiceImpl()
        }
        container.register(PokemonDisplayerViewModel.self) { PokemonDisplayerViewModel() }
        container.register(CreateAccountViewModel.self) { CreateAccountViewModel() }
        
        container.register(PokemonDetailsService.self) {
            //PokemonDetailsMockServiceImpl()
            PokemonDetailsServiceImpl()
        }
        
        container.register(PokemonImageService.self) {
            PokemonImageMockServiceImpl()
        }
        
        container.register(PokemonDetailsViewModel.self) {
            PokemonDetailsViewModel()
        }
        
    }
}
