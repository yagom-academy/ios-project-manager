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
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    private let previewLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, previewLabel, dateLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
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
            containerView.layer.cornerRadius = 10
            containerView.backgroundColor = .systemBlue
            titleLabel.textColor = .white
            previewLabel.textColor = .white
            dateLabel.textColor = .white
        } else {
            containerView.layer.cornerRadius = 0
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
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            labelStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            labelStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            labelStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10)
        ])
    }
}
