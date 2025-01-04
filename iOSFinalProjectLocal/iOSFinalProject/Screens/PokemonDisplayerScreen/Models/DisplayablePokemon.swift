//
//  PokemonCastMember.swift
//  iOSFinalProject
//
//  Created by GenericDevCalifornia on 12/31/24.
//

import Foundation

struct DisplayablePokemon: Codable {
    let id: Int
    let name: String
    let abilities: [String]
    let types: [String]
    let image: String
    let height: Float
    let weight: Float
}
