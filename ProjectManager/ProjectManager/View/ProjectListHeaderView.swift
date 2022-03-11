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
        badgeLabel.layer.cornerRadius = Design.badgeLabelCornerRadius
        badgeLabel.text = Text.defaultBadgeLabel
        
        return badgeLabel
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func updateProjectCount(_ count: Int) {
        badgeLabel.text = count.description
    }
    
    private func commonInit() {
        backgroundColor = .secondarySystemBackground
        setupHeaderViewLayout()
    }
    
    private func setupHeaderViewLayout() {
        addSubview(titleLabel)
        addSubview(underLine)
        addSubview(badgeLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Design.labelMargin),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            badgeLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            badgeLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: Design.labelMargin),
            badgeLabel.widthAnchor.constraint(equalToConstant: Design.badgeLabelWidth),
            badgeLabel.heightAnchor.constraint(equalTo: badgeLabel.widthAnchor),
            underLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            underLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            underLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            underLine.heightAnchor.constraint(equalToConstant: Design.underLineHeight)
        ])
    }
}

private enum Text {
    static let defaultBadgeLabel = "0"
}

private enum Design {
    static let badgeLabelCornerRadius: CGFloat = 10
    static let labelMargin: CGFloat = 10
    static let badgeLabelWidth: CGFloat = 20
    static let underLineHeight: CGFloat = 0.3
}
