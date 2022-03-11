import UIKit

class ProjectListCell: UITableViewCell {
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.numberOfLines = Design.defaultTextLine
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    private let previewLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.numberOfLines = Design.previewTextLine
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = Design.defaultTextLine
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, previewLabel, dateLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = Design.stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            containerView.layer.cornerRadius = Design.selectedCornerRadius
            containerView.backgroundColor = .systemBlue
            titleLabel.textColor = .white
            previewLabel.textColor = .white
            dateLabel.textColor = .white
        } else {
            containerView.layer.cornerRadius = Design.defaultCornerRadius
            containerView.backgroundColor = .systemBackground
            titleLabel.textColor = .label
            previewLabel.textColor = .secondaryLabel
            dateLabel.textColor = .label
        }
    }
    
    func setupLabelText(title: String, preview: String, date: String) {
        titleLabel.text = title
        previewLabel.text = preview
        dateLabel.text = date
    }
    
    private func commonInit() {
        contentView.addSubview(labelStackView)
        setupBackgroundColor()
        setupLabelStackViewLayout()
    }
    
    private func setupBackgroundColor() {
        contentView.backgroundColor = .secondarySystemBackground
    }
    
    private func setupLabelStackViewLayout() {
        contentView.addSubview(containerView)
        containerView.addSubview(labelStackView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Design.layoutMargin),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Design.layoutMargin),
            labelStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Design.layoutMargin),
            labelStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Design.layoutMargin),
            labelStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Design.layoutMargin)
        ])
    }
}

private enum Design {
    static let defaultTextLine = 1
    static let previewTextLine = 3
    static let stackViewSpacing: CGFloat = 10
    static let defaultCornerRadius: CGFloat = 0
    static let selectedCornerRadius: CGFloat = 10
    static let layoutMargin: CGFloat = 10
}
