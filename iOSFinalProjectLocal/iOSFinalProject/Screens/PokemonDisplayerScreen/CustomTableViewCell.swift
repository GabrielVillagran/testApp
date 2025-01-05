import UIKit

class CharacterTableViewCell: UITableViewCell {
    lazy var idLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CharacterTableViewCell {
    private func setupViews() {
        contentView.addSubview(idLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(heightLabel)
        contentView.addSubview(weightLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            idLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -15),

            heightLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 5),
            heightLabel.leadingAnchor.constraint(equalTo: idLabel.leadingAnchor),
            heightLabel.trailingAnchor.constraint(equalTo: idLabel.trailingAnchor),
            heightLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),

            nameLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: heightLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: heightLabel.trailingAnchor),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),

            weightLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            weightLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            weightLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            weightLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configureInfo(with character: DisplayablePokemon) {
        idLabel.text = "id : \(character.id)"
        nameLabel.text = "Name: \(character.name)"
        heightLabel.text = "Height: \(character.height)"
        weightLabel.text = "Weight: \(character.weight)"
    }
}
