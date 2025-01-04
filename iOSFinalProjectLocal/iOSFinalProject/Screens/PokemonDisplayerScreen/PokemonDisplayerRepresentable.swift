//
//  PokemonDisplayerRepresentable.swift
//  iOSFinalProject
//
//  Created by GenericDevCalifornia on 1/3/25.
//
import SwiftUI
import UIKit

struct PokemonDisplayerViewWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return PokemonDisplayerView()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {

    }

}
