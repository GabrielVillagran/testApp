//
//  PokemonImageService.swift
//  iOSFinalProject
//
//  Created by Trainee on 1/10/25.
//

import Foundation
import UIKit

protocol PokemonImageService {
    func loadPokemonImage(from url: URL) async throws -> UIImage
    
}

class PokemonImageMockServiceImpl: PokemonImageService {
    
    private let session: URLSession = URLSession.shared
    private let decoder: JSONDecoder = JSONDecoder()
    
    func loadPokemonImage(from url: URL) async throws -> UIImage {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {throw Errors.invalidURL }
            return image
        } catch {
            throw (Errors.invalidResponse)
        }
    }
}
