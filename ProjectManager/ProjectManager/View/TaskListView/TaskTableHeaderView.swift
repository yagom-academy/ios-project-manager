import UIKit

class TaskTableHeaderView: UITableViewHeaderFooterView {
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .title1)
        label.text = ""
        
        return label
    }()
    
    var countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
        setupHeight()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        let inset = 10.0
        stackView.layoutMargins = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(countLabel)
    }
    
    private func setupHeight() {
        let height = 55.0 // TODO: dynamic height 지정
        self.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: height) // titleLabel.bounds.height는 왜 안되지?
    }
    
    func applyData(with title: String) {
        titleLabel.text = title
    }
    
    func applyData(with count: Int) {
        countLabel.text = "\(count)"
    }
}
