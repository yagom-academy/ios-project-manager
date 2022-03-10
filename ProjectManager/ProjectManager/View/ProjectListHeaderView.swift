import UIKit

class ProjectListHeaderView: UIView {
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .preferredFont(forTextStyle: .largeTitle)
        
        return titleLabel
    }()
    
    private let underLine: UIView = {
        let underLine = UIView()
        underLine.translatesAutoresizingMaskIntoConstraints = false
        underLine.backgroundColor = .systemGray2
        
        return underLine
    }()
    
    private let badgeLabel: UILabel = {
        let badgeLabel = UILabel()
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        badgeLabel.font = .preferredFont(forTextStyle: .caption2)
        badgeLabel.textColor = .systemBackground
        badgeLabel.textAlignment = .center
        badgeLabel.backgroundColor = .label
        badgeLabel.layer.masksToBounds = true
        badgeLabel.layer.cornerRadius = 10
        badgeLabel.text = "0"
        
        return badgeLabel
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        setupTableHeaderView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableHeaderView() {
        backgroundColor = .secondarySystemBackground
        setupHeaderViewLayout()
    }
    
    private func setupHeaderViewLayout() {
        addSubview(titleLabel)
        addSubview(underLine)
        addSubview(badgeLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -2.5),
            badgeLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            badgeLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10),
            badgeLabel.widthAnchor.constraint(equalToConstant: 20),
            badgeLabel.heightAnchor.constraint(equalToConstant: 20),
            underLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            underLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            underLine.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            underLine.heightAnchor.constraint(equalToConstant: 0.3)
        ])
    }
    
    func updateProjectCount(_ count: Int) {
        badgeLabel.text = count.description
    }
}
