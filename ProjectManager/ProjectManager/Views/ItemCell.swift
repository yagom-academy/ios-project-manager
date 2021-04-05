import UIKit

class ItemCell: UICollectionViewCell {
    static let identifier = String(describing: ItemCell.self)

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        titleLabel.text = "라자냐 재료 사러가기"
        return titleLabel
    }()
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        descriptionLabel.numberOfLines = 3
        descriptionLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.textColor = .lightGray
        //TODO: Line spacing 조절하기
        //TODO: 설명이 세 줄 이상이면 세 줄 까지만 표시합니다. 설명이 세 줄 이하라면, 설명글의 높이에 맞게 셀의 높이가 맞춰집니다
        descriptionLabel.text = "내가 가는 이길이 어디로 가는지 어디로 날 데려가는지 그 곳은 어딘지 알 수 없지만 알 수 없지만 오늘도 난 걸어가고 있네 사람들은 길이 다 정해져 있다고, 오늘도 난 걸어가고 있네 사람들은 길이 다 정해져 있다고, 오늘도 난 걸어가고 있네 사람들은 길이 다 정해져 있다고"
        return descriptionLabel
    }()
    private lazy var expirationDateLabel: UILabel = {
        let expirationDateLabel = UILabel()
        expirationDateLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        expirationDateLabel.text = "2021.04.03."
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
}
