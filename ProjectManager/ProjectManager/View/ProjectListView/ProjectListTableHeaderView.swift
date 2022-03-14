import UIKit

final class ProjectListTableHeaderView: UITableViewHeaderFooterView {
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
        label.bounds = Design.totalCountLabelBounds
        label.layer.cornerRadius = Design.totalCountLabelCornerRadius
        label.layer.masksToBounds = true
        return label
    }()
    
    private let spacerView: UIView = {
        let view = UIView()
        view.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        view.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
        return view
    }()
    
    private let entireStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = Design.entireStackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addSubview(entireStackView)
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        configureEntireStackView()
        configureLayout()
    }

    private func configureEntireStackView() {
        [titleLabel, totalCountLabel, spacerView].forEach {
            entireStackView.addArrangedSubview($0)
        }
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            totalCountLabel.widthAnchor.constraint(equalTo: totalCountLabel.heightAnchor),
            totalCountLabel.topAnchor.constraint(equalTo: entireStackView.topAnchor, constant: LayoutConstant.totalCountLabelTopMargin),
            totalCountLabel.bottomAnchor.constraint(equalTo: entireStackView.bottomAnchor, constant: LayoutConstant.totalCountLabelBottomMargin),
            entireStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: LayoutConstant.entireStackViewLeadingMargin),
            entireStackView.topAnchor.constraint(equalTo: self.topAnchor),
            entireStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            entireStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func populateData(title: String, count: Int) {
        titleLabel.text = title
        totalCountLabel.text = "\(count)"
    }
}

//MARK: - Constants

private extension ProjectListTableHeaderView {
    enum LayoutConstant {
        static let totalCountLabelTopMargin: CGFloat = 10
        static let totalCountLabelBottomMargin: CGFloat = -10
        static let entireStackViewLeadingMargin: CGFloat = 10
    }

    enum Design {
        static let totalCountLabelBounds: CGRect = CGRect(x: 0, y: 0, width: 30, height: 30)
        static let totalCountLabelCornerRadius: CGFloat = 30/2
        static let entireStackViewSpacing: CGFloat = 10
    }
}
