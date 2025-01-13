import Foundation
import UIKit
import Combine

class PokemonDisplayerView: UIViewController {
    @Inject private var viewModel: PokemonDisplayerViewModel
    var castDisplayer: UITableView = UITableView(frame: .zero)
    private var cast: [DisplayablePokemon] = []
    private var loader: UIActivityIndicatorView = UIActivityIndicatorView()
    private var subscription: [AnyCancellable] = []

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCastDisplayer()
        setupViewModel()
        castDisplayer.dataSource = self
        castDisplayer.delegate = self
        castDisplayer.translatesAutoresizingMaskIntoConstraints = false
        observeViewModel()
        loadViewDesign()
    }
}

private extension PokemonDisplayerView {
    func setupCastDisplayer() {
        castDisplayer.register(CharacterTableViewCell.self, forCellReuseIdentifier: Constants.tableViewCellIdentifier)
        view.addSubview(castDisplayer)
        setupConstraintsTableView()
    }

    func setupViewModel() {
        viewModel.initialize()
    }

    func loadViewDesign() {
        view.addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.center = view.center
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        loader.hidesWhenStopped = true
    }

    func setupConstraintsTableView() {
        NSLayoutConstraint.activate([
            castDisplayer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            castDisplayer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            castDisplayer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            castDisplayer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    private enum Constants {
        static let tableViewCellIdentifier = "CharacterTableViewCell"
    }
}

extension PokemonDisplayerView {

    func observeViewModel() {
        viewModel.$pokemonState.sink { [weak self] state in
            guard let self else { return }
            switch state {
            case .loading:
                showLoader()
            case .error(let error):
                show(errorMessage: error)
                hideLoader()
            case .success(let pokemons): display(cast: pokemons)
                hideLoader()
            }
        }
        .store(in: &subscription)
    }

    func display(cast: [DisplayablePokemon]) {
        self.cast = cast
        castDisplayer.reloadData()
    }

    func showLoader() {
        loader.startAnimating()
    }

    func hideLoader() {
        loader.stopAnimating()
    }

    func show(errorMessage: String) {
        let aleertMessage = UIAlertController(title: Constants.tableViewCellIdentifier,message: errorMessage, preferredStyle: .alert)
        aleertMessage.addAction(UIAlertAction(title: Constants.tableViewCellIdentifier, style: .default))
        present(aleertMessage, animated: true)
    }
}

extension PokemonDisplayerView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cast.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellIdentifier, for: indexPath) as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        cell.configureInfo(with: cast[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPokemon = cast[indexPath.row]
        let pokemonDetailsView = PokemonDetailsView(id: selectedPokemon.id)
            present(pokemonDetailsView, animated: true, completion: nil)
            tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func moveToDetails(id: Int,closure: @escaping () -> PokemonDisplayerView) {
        
    }
}

fileprivate extension UITableViewCell {
    static var identifier: String {
        "cell_identifier"
    }
}
