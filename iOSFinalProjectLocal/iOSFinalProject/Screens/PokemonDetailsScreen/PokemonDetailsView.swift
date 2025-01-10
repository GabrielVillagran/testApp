//
//  PokemonDetailsView.swift
//  iOSFinalProject
//
//  Created by Trainee on 1/9/25.
//

import Foundation
import UIKit
import Combine

class PokemonDetailsView: UIViewController {
    
    @Inject private var viewModel: PokemonDetailsViewModel
    
    private var pokemon: DisplayablePokemon?
    private var subscription: [AnyCancellable] = []
    
    
    
    private var pokemonName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    private var abilitiesView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomPokemonCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var typesView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomPokemonCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .gray
        return collectionView
    }()
    
    private var pokemonHeight: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    private var pokemonWeight: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    private var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViewModel()
        observeViewModelPokemonState()
        setupLabels()
        setupViews()
        setupImage()
        observeViewModelImageState()
        setupLoader()
    }
    
    private func setupViewModel() {
        viewModel.initialize()
    }
    
    private func setupViews() {
        abilitiesView.dataSource = self
        typesView.dataSource = self
        view.addSubview(abilitiesView)
        view.addSubview(typesView)
        
        NSLayoutConstraint.activate([
            abilitiesView.topAnchor.constraint(equalTo: pokemonWeight.bottomAnchor, constant: 20),
            abilitiesView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            abilitiesView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            abilitiesView.heightAnchor.constraint(equalToConstant: 100),
            
            typesView.topAnchor.constraint(equalTo: abilitiesView.bottomAnchor, constant: 20),
            typesView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            typesView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            typesView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupLabels() {
        view.addSubview(pokemonName)
        view.addSubview(pokemonHeight)
        view.addSubview(pokemonWeight)
        
        NSLayoutConstraint.activate([
            pokemonName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            pokemonName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            pokemonName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            pokemonHeight.topAnchor.constraint(equalTo: pokemonName.bottomAnchor, constant: 10),
            pokemonHeight.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            pokemonHeight.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            pokemonWeight.topAnchor.constraint(equalTo: pokemonHeight.bottomAnchor, constant: 10),
            pokemonWeight.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            pokemonWeight.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupImage() {
        view.addSubview(pokemonImageView)
        NSLayoutConstraint.activate([
            pokemonImageView.topAnchor.constraint(equalTo: typesView.bottomAnchor, constant: 20),
            pokemonImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            pokemonImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 300),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setupLoader() {
        view.addSubview(loader)
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension PokemonDetailsView {
    func showLoader() {
        loader.startAnimating()
    }
    
    func hideLoader() {
        loader.stopAnimating()
    }
    
    func show(errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    func showImage(image: UIImage) {
        DispatchQueue.main.async {
            self.pokemonImageView.image = image
        }
    }
    
    func displayInfo(pokemon: DisplayablePokemon) {
        hideLoader()
        self.pokemon = pokemon
        pokemonName.text = pokemon.name
        pokemonHeight.text = String(pokemon.height)
        pokemonWeight.text = String(pokemon.weight)
        loadImage(url: pokemon.image)
        abilitiesView.reloadData()
        typesView.reloadData()
        
    }

    func loadImage(url: String) {
        guard let imageURL = URL(string: url) else { return }
        viewModel.fetchMovieImage(url: imageURL)
    }
    
    func observeViewModelPokemonState() {
        viewModel.$pokemonState.sink { [weak self] state in
            guard let self else { return }
            switch state {
            case .loading:
                showLoader()
            case .error(let error):
                show(errorMessage: error)
                hideLoader()
            case .success(let pokemon): displayInfo(pokemon: pokemon)
                hideLoader()
            }
        }
        .store(in: &subscription)
    }
    
    func observeViewModelImageState() {
        viewModel.$imageState.sink { [weak self] state in
            guard let self else { return }
            switch state {
            case .error(let errorMessage): show(errorMessage: errorMessage)
            case .loading: showLoader()
            case .success(let image): showImage(image: image)
            }
        }
        .store(in: &subscription)
    }
    
}

extension PokemonDetailsView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let pokemon else { return 0 }
        if collectionView == abilitiesView {
            return pokemon.abilities.count
        } else {
            return pokemon.types.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let pokemon else { return UICollectionViewCell() }
        
        if collectionView == abilitiesView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomPokemonCell
            let ability = pokemon.abilities[indexPath.item]
            cell.backgroundColor = .systemBlue
            cell.configure(with: ability)
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomPokemonCell
            cell.backgroundColor = .systemGreen
            let type = pokemon.types[indexPath.item]
            cell.configure(with: type)
            return cell
        }
    }
}
