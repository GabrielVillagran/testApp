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
    
    @Inject var viewModel: PokemonDetailsViewModel
    
    private var id: Int?
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var pokemon: DisplayablePokemon?
    private var subscription: [AnyCancellable] = []
    
    private var pokemonName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: FontSizes.pokemonDetailsLabelFontSize.rawValue)
        return label
    }()
    
    private func createCustomStackView () -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = GeneralCGFloatValues.stackViewDetailsSpacing.rawValue
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }
    
    private var abilitiesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = GeneralCGFloatValues.stackViewDetailsSpacing.rawValue
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private var typesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = GeneralCGFloatValues.stackViewDetailsSpacing.rawValue
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private var pokemonHeight: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: FontSizes.pokemonDetailsLabelFontSize.rawValue)
        return label
    }()
    
    private var pokemonWeight: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: FontSizes.pokemonDetailsLabelFontSize.rawValue)
        return label
    }()
    
    private var pokemonAbilitiesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: FontSizes.pokemonDetailsLabelFontSize.rawValue)
        label.text = "Abilities:"
        return label
    }()
    
    private var pokemonTypesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: FontSizes.pokemonDetailsLabelFontSize.rawValue)
        label.text = "Types:"
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
        setupViews()
        setupLabels()
        setupStackViews()
        setupImage()
        observeViewModelImageState()
        setupLoader()
    }
    
    private func setupViewModel() {
        viewModel.initialize(id: id)
    }
    
    private func setupViews() {
        view.addSubview(abilitiesStackView)
        view.addSubview(typesStackView)
        view.addSubview(pokemonName)
        view.addSubview(pokemonHeight)
        view.addSubview(pokemonWeight)
        view.addSubview(pokemonAbilitiesLabel)
        view.addSubview(pokemonTypesLabel)
        view.addSubview(pokemonImageView)
        view.addSubview(loader)
    }
    
    private func setupStackViews() {
        NSLayoutConstraint.activate([
            abilitiesStackView.topAnchor.constraint(equalTo: pokemonWeight.safeAreaLayoutGuide.bottomAnchor, constant: GeneralCGFloatValues.constrainConstantBigSpace.rawValue),
            abilitiesStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: GeneralCGFloatValues.constraintConstantSpace.rawValue),
            abilitiesStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: GeneralCGFloatValues.constraintConstantNegativeSpace.rawValue),
            abilitiesStackView.heightAnchor.constraint(equalToConstant: GeneralCGFloatValues.constantHeightAnchor.rawValue),
            
            typesStackView.topAnchor.constraint(equalTo: abilitiesStackView.bottomAnchor, constant: GeneralCGFloatValues.constrainConstantBigSpace.rawValue),
            typesStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: GeneralCGFloatValues.constraintConstantSpace.rawValue),
            typesStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: GeneralCGFloatValues.constraintConstantNegativeSpace.rawValue),
            typesStackView.heightAnchor.constraint(equalToConstant: GeneralCGFloatValues.constantHeightAnchor.rawValue)
        ])
    }
    
    private func setupLabels() {
        NSLayoutConstraint.activate([
            pokemonName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: GeneralCGFloatValues.constraintConstantSpace.rawValue),
            pokemonName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: GeneralCGFloatValues.constraintConstantSpace.rawValue),
            pokemonName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: GeneralCGFloatValues.constraintConstantNegativeSpace.rawValue),
            
            pokemonHeight.topAnchor.constraint(equalTo: pokemonName.bottomAnchor, constant: GeneralCGFloatValues.stackViewDetailsSpacing.rawValue),
            pokemonHeight.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: GeneralCGFloatValues.constraintConstantSpace.rawValue),
            pokemonHeight.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: GeneralCGFloatValues.constraintConstantNegativeSpace.rawValue),
            
            pokemonWeight.topAnchor.constraint(equalTo: pokemonHeight.bottomAnchor, constant: GeneralCGFloatValues.stackViewDetailsSpacing.rawValue),
            pokemonWeight.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: GeneralCGFloatValues.constraintConstantSpace.rawValue),
            pokemonWeight.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: GeneralCGFloatValues.constraintConstantNegativeSpace.rawValue),
            
            pokemonAbilitiesLabel.topAnchor.constraint(equalTo: pokemonWeight.bottomAnchor, constant: GeneralCGFloatValues.stackViewDetailsSpacing.rawValue),
            pokemonAbilitiesLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: GeneralCGFloatValues.constraintConstantSpace.rawValue),
            pokemonAbilitiesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: GeneralCGFloatValues.constraintConstantNegativeSpace.rawValue),
            
            pokemonTypesLabel.topAnchor.constraint(equalTo: abilitiesStackView.bottomAnchor, constant: GeneralCGFloatValues.stackViewDetailsSpacing.rawValue),
            pokemonTypesLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: GeneralCGFloatValues.constraintConstantSpace.rawValue),
            pokemonTypesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: GeneralCGFloatValues.constraintConstantNegativeSpace.rawValue)
        ])
    }
    
    private func setupImage() {
        NSLayoutConstraint.activate([
            pokemonImageView.topAnchor.constraint(equalTo: typesStackView.bottomAnchor, constant: GeneralCGFloatValues.constraintConstantSpace.rawValue),
            pokemonImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: GeneralCGFloatValues.constraintConstantSpace.rawValue),
            pokemonImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: GeneralCGFloatValues.constraintConstantNegativeSpace.rawValue),
            pokemonImageView.heightAnchor.constraint(equalToConstant: GeneralCGFloatValues.constantImageHeightAnchor.rawValue),
            pokemonImageView.widthAnchor.constraint(equalToConstant: GeneralCGFloatValues.constantImageWidthAnchor.rawValue)
        ])
    }
    
    private func setupLoader() {
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
        pokemonName.text = "Name: \(pokemon.name)"
        pokemonHeight.text = "Height: \(pokemon.height)"
        pokemonWeight.text = "Weight: \(pokemon.weight)"
        loadImage(url: pokemon.image)
        updateAbilitiesStackView()
        updateTypesStackView()
        
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

extension PokemonDetailsView {
    
    private func updateAbilitiesStackView() {
        guard let abilities = pokemon?.abilities else { return }
        
        for ability in abilities {
            let label = UILabel()
            label.text = ability
            label.textAlignment = .center
            label.textColor = .white
            label.backgroundColor = .systemBlue
            label.layer.cornerRadius = GeneralCGFloatValues.constantCornerRadius.rawValue
            label.layer.masksToBounds = true
            label.numberOfLines = Constants.zeroValue.rawValue
            label.font = UIFont.systemFont(ofSize: FontSizes.pokemonDetailsStackViewFontSize.rawValue)
            abilitiesStackView.addArrangedSubview(label)
        }
    }
    
    private func updateTypesStackView() {
        guard let types = pokemon?.types else { return }
        
        for type in types {
            let label = UILabel()
            label.text = type
            label.textAlignment = .center
            label.textColor = .white
            label.backgroundColor = .systemGreen
            label.layer.cornerRadius = GeneralCGFloatValues.constantCornerRadius.rawValue
            label.layer.masksToBounds = true
            label.numberOfLines = Constants.zeroValue.rawValue
            label.font = UIFont.systemFont(ofSize: FontSizes.pokemonDetailsStackViewFontSize.rawValue)
            typesStackView.addArrangedSubview(label)
        }
    }
}
