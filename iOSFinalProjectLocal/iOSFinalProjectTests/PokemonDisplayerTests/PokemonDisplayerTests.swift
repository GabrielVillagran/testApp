//
//  PokemonDisplayerTests.swift
//  iOSFinalProjectTests
//
//  Created by GenericDevCalifornia on 1/3/25.
//

import XCTest
@testable import iOSFinalProject

final class PokemonDisplayerTests: XCTestCase {

    private var mockPokemonTestService: MockPokemonTestService!
    private var pokemonDisplayerViewModel: PokemonDisplayerViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockPokemonTestService = MockPokemonTestService()
        pokemonDisplayerViewModel = PokemonDisplayerViewModel(service: mockPokemonTestService)

    }

    override func tearDownWithError() throws {
        pokemonDisplayerViewModel = nil
        mockPokemonTestService = nil
        try super.tearDownWithError()
    }

    func initializeMethodTestingIsSuccesfull() async {
        // Given
        let expectedPokemon = DisplayablePokemon(
            id: 1,
            name: "Bulbasur",
            abilities: ["1", "2"],
            types: ["fire", "water"],
            image: "http:url",
            height: 5.7,
            weight: 90.89
        )

        mockPokemonTestService.failResponse = false
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { expectation.fulfill() }

        // When
        pokemonDisplayerViewModel.initialize()

        // Then
        await fulfillment(of: [expectation], timeout: 1.0)

        if case .success(let actualPokemons) = pokemonDisplayerViewModel.pokemonState {
            XCTAssertEqual(actualPokemons.first?.id, expectedPokemon.id)
            XCTAssertEqual(actualPokemons.first?.name, expectedPokemon.name)
            XCTAssertEqual(actualPokemons.first?.abilities, expectedPokemon.abilities)
            XCTAssertEqual(actualPokemons.first?.types, expectedPokemon.types)
            XCTAssertEqual(actualPokemons.first?.image, expectedPokemon.image)
            XCTAssertEqual(actualPokemons.first?.height, expectedPokemon.height)
            XCTAssertEqual(actualPokemons.first?.weight, expectedPokemon.weight)
        } else {
            XCTFail("Expected state to be .success but got \(pokemonDisplayerViewModel.pokemonState)")
        }
    }

    func initializeMethodTestingIsFail() async {
        // Given
        let expectedError = "404 Not Found"

        mockPokemonTestService.failResponse = true
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { expectation.fulfill() }

        // When
        pokemonDisplayerViewModel.initialize()

        // Then
        await fulfillment(of: [expectation], timeout: 1.0)
        if case .error(let error) = pokemonDisplayerViewModel.pokemonState {
            XCTAssertEqual(error, expectedError)
        }
    }

}
