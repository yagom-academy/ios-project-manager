import UIKit

class ItemCell: UICollectionViewCell {
    static let identifier = String(describing: ItemCell.self)

     lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return titleLabel
    }()
     lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        descriptionLabel.numberOfLines = 3
        descriptionLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.textColor = .lightGray
        return descriptionLabel
    }()
     lazy var expirationDateLabel: UILabel = {
        let expirationDateLabel = UILabel()
        expirationDateLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return expirationDateLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ItemCell {
    private func setConstraints() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(expirationDateLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        expirationDateLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            expirationDateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            expirationDateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            expirationDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            expirationDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
    }

    func configure(thing: Thing, datePassed: Bool) {
        titleLabel.text = thing.title
        descriptionLabel.text = thing.des
        let dateFormatter = DateFormatter()
        guard let dueDate = thing.dueDate else { return }
        let date = Date(timeIntervalSince1970: dueDate)
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let languageCode = NSLocale.preferredLanguages[0]
        dateFormatter.locale = Locale(identifier: languageCode)
        expirationDateLabel.text = dateFormatter.string(from: date)
        
        if datePassed {
            expirationDateLabel.textColor = .systemRed
        } else {
            expirationDateLabel.textColor = .label
        }
    }
}
