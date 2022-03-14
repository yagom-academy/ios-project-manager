import UIKit

class ProjectUITableViewCell: UITableViewCell {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.text = "name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = .preferredFont(forTextStyle: .body)
        label.text = "detail"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let deadLineLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.text = "deadline"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                nameLabel,
                detailLabel,
                deadLineLabel
            ]
        )
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5.0
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .red
        addViews()
        configureLayout()
    }
    
    private func addViews() {
        self.addSubview(stackView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
}
