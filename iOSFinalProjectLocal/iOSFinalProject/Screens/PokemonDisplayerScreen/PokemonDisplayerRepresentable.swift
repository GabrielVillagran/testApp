import SwiftUI
import UIKit

struct PokemonDisplayerViewWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return PokemonDisplayerView()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {

    }

}
