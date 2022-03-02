import UIKit

class ProjectListTableHeaderView: UITableViewHeaderFooterView {
    static let identifier = String(describing: self)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }()
    
    private let totalCountLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .callout)
        label.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
        label.layer.cornerRadius = 30 / 2
        label.layer.masksToBounds = true
        return label
    }()
    
    private let spacerView: UIView = {
        let view = UIView()
        view.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        view.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, totalCountLabel, spacerView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addSubview(stackView)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        configureLayout()
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            totalCountLabel.widthAnchor.constraint(equalTo: totalCountLabel.heightAnchor),
            totalCountLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 10),
            totalCountLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func populateData(title: String, count: Int) {
        titleLabel.text = title
        totalCountLabel.text = "\(count)"
    }
}
