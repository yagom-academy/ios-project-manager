import UIKit

private enum LayoutConstant {
    static let entireStackViewTopMargin: CGFloat = 15
    static let entireStackViewTrailingMargin: CGFloat = -15
    static let entireStackViewBottomMargin: CGFloat = -15
    static let entireStackViewLeadingMargin: CGFloat = 15
}

private enum Design {
    static let entireStackViewSpacing: CGFloat = 10
    static let cellContentViewFrameInset: UIEdgeInsets = UIEdgeInsets(top: 3.5, left: 0, bottom: 3.5, right: 0)
}

class ProjectTableViewCell: UITableViewCell {
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
    
    private let entireStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = Design.entireStackViewSpacing
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
        self.contentView.frame = self.contentView.frame.inset(by: Design.cellContentViewFrameInset)
        contentView.backgroundColor = .white
        self.backgroundColor = .systemGray6
    }
    
    private func configureUI() {
        self.contentView.addSubview(entireStackView)
        configureEntireStackView()
        configureLayout()
    }
    
    private func configureEntireStackView() {
        [titleLabel, bodyLabel, dateLabel].forEach {
            entireStackView.addArrangedSubview($0)
        }
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            self.entireStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: LayoutConstant.entireStackViewTopMargin),
            self.entireStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: LayoutConstant.entireStackViewTrailingMargin),
            self.entireStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: LayoutConstant.entireStackViewBottomMargin),
            self.entireStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: LayoutConstant.entireStackViewLeadingMargin)
        ])
    }
}
