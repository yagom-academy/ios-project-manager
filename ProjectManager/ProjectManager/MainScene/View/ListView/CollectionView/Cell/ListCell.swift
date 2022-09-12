//
//  ListCell.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/09.
//

import UIKit

final class ListCell: UICollectionViewCell {
    // MARK: - UIComponents
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 3
        label.textColor = .systemGray
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        return label
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialView()
        setupVerticalStackView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    // MARK: - Methods
    private func setupInitialView() {
        backgroundColor = .white
    }
    
    private func setupVerticalStackView() {
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(bodyLabel)
        verticalStackView.addArrangedSubview(dateLabel)
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 10
            ),
            verticalStackView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -10
            ),
            verticalStackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20
            ),
            verticalStackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -20
            )
        ])
    }
    
    func setup(with model: TodoModel) {
        titleLabel.text = model.title
        bodyLabel.text = model.body
        dateLabel.text = model.date.timeIntervalSince1970.translateToDate()
        if model.date < Date() {
            dateLabel.textColor = .red
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        bodyLabel.text = nil
        dateLabel.text = nil
        dateLabel.textColor = nil
    }
    
    override func draw(_ rect: CGRect) {
        let separator = UIBezierPath()
        separator.move(to: CGPoint(x: 0, y: bounds.maxY))
        separator.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        separator.lineWidth = 2
        UIColor.lightGray.setStroke()
        separator.stroke()
        separator.close()
    }
}
