import UIKit

final class ProjectListTableViewCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .left
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 3
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
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
        super.init(coder: coder)
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
    
    func populateData(title: String, body: String, date: Date) {
        self.titleLabel.text = title
        self.bodyLabel.text = body
        self.dateLabel.text = date.formattedDate
        self.dateLabel.textColor = .black
    }
    
    func populateDataWithDate(title: String, body: String, date: Date) {
        self.titleLabel.text = title
        self.bodyLabel.text = body
        self.dateLabel.text = date.formattedDate
        self.dateLabel.textColor = .red
    }
}

//MARK: - Constants

private extension ProjectListTableViewCell {
    enum LayoutConstant {
        static let entireStackViewTopMargin: CGFloat = 15
        static let entireStackViewTrailingMargin: CGFloat = -15
        static let entireStackViewBottomMargin: CGFloat = -15
        static let entireStackViewLeadingMargin: CGFloat = 15
    }

    enum Design {
        static let entireStackViewSpacing: CGFloat = 5
        static let cellContentViewFrameInset: UIEdgeInsets = UIEdgeInsets(top: 3.5, left: 0, bottom: 3.5, right: 0)
    }
}
