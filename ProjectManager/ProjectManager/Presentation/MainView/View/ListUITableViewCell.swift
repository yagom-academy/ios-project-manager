import UIKit

final class ListUITableViewCell: UITableViewCell {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = .preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let deadLineLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                self.nameLabel,
                self.detailLabel,
                self.deadLineLabel
            ]
        )
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5.0
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addViews()
        self.configureLayout()
    }
    
    func configureCellUI(data: Listable) {
        self.nameLabel.text = data.name
        self.deadLineLabel.text = data.deadline.description
        self.detailLabel.text = data.detail
    }
    
    private func addViews() {
        self.addSubview(stackView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            self.stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            self.stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            self.stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
}
