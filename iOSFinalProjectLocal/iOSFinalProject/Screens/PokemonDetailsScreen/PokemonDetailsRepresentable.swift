//
//  PokemonDetailsRepresentable.swift
//  iOSFinalProject
//
//  Created by Trainee on 1/10/25.
//

import Foundation
import UIKit
import SwiftUI

struct PokemonDetailsViewWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return PokemonDetailsView()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {

    }

}
