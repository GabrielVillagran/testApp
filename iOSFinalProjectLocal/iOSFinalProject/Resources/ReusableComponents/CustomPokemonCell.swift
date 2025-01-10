//
//  CustomPokemonCell.swift
//  iOSFinalProject
//
//  Created by Trainee on 1/10/25.
//

import Foundation
import UIKit

class CustomPokemonCell: UICollectionViewCell {
    
    var pokemonLabel: UILabel  = {
        let pokemonLabel = UILabel()
        pokemonLabel.translatesAutoresizingMaskIntoConstraints = false
        pokemonLabel.font = UIFont.systemFont(ofSize: 16)
//        pokemonLabel.numberOfLines = 0
        pokemonLabel.textAlignment = .center
        pokemonLabel.textColor = .white
        pokemonLabel.contentMode = .scaleAspectFill
        return pokemonLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        
        contentView.addSubview(pokemonLabel)
        
        NSLayoutConstraint.activate([
            pokemonLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            pokemonLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            pokemonLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            pokemonLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configure(with text: String) {
        pokemonLabel.text = text
    }

}
