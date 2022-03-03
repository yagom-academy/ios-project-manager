import UIKit

class ProjectTableViewCell: UITableViewCell {
    static let identifier = String(describing: self)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.text = "책상정리"
        label.textAlignment = .left
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.text = "집중이 안될 땐 역시나 책상정리"
        label.numberOfLines = 3
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.text = "2021.11.5."
        label.textAlignment = .left
        return label
    }()
    
    private lazy var entireStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, bodyLabel, dateLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 7, left: 0, bottom: 0, right: 0))
        contentView.backgroundColor = .white
        self.backgroundColor = .systemGray6
    }
    
    private func configureUI() {
        self.contentView.addSubview(entireStackView)
        configureLayout()
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            self.entireStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            self.entireStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            self.entireStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15),
            self.entireStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15)
        ])
    }
}
