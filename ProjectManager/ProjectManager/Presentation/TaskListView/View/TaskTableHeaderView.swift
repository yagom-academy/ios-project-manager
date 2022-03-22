import UIKit

private enum Design {
    static let frameHeight: CGFloat = 50
}

class TaskTableHeaderView: UITableViewHeaderFooterView {
    var processStatus: ProcessStatus
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .title1)
        return label
    }()
    
    var taskCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .title1)
        return label
    }()
    
    init(reuseIdentifier: String?, processStatus: ProcessStatus) { 
        self.processStatus = processStatus
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
        setupFrame()
        setupLabel()
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
        stackView.setContentHuggingPriority(.defaultLow, for: .vertical)
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
        stackView.addArrangedSubview(taskCountLabel)
    }
    
    private func setupFrame() {
        self.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: Design.frameHeight)
    }
    
    func setupLabel() {
        titleLabel.text = processStatus.description
    }
}
