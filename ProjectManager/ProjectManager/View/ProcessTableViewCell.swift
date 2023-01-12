//
//  ProcessTableViewCell.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/12.
//

import UIKit

final class ProcessTableViewCell: UITableViewCell {
    private enum UIConstraint {
        static let stackViewSpacing = 5.0
        static let topValue = 10.0
        static let bottomValue = -10.0
        static let leadingValue = 10.0
        static let trailingValue = -10.0
    }
    
    let titleLabel = UILabel(fontStyle: .title3)
    let descriptionLabel = UILabel(fontStyle: .body)
    let dateLabel = UILabel(fontStyle: .body)
    
    private lazy var stackView = UIStackView(
        views: [titleLabel, descriptionLabel, dateLabel],
        axis: .vertical,
        alignment: .leading,
        distribution: .fill,
        spacing: UIConstraint.stackViewSpacing
    )
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Configuration
extension ProcessTableViewCell {
    private func setupView() {
        contentView.addSubview(stackView)
    }
    
    private func setupConstraint() {
        let safeArea = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: safeArea.topAnchor,
                constant: UIConstraint.topValue
            ),
            stackView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: UIConstraint.leadingValue
            ),
            stackView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor,
                constant: UIConstraint.trailingValue
            ),
            stackView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: UIConstraint.bottomValue
            )
        ])
    }
}

extension ProcessTableViewCell: IdentifierUsable { }
