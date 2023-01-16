//
//  ProcessTableViewCell.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/12.
//

import UIKit

final class ProcessTableViewCell: UITableViewCell {
    private enum UIConstant {
        static let titleNumberLine = 1
        static let descriptionNumberLine = 3
        static let stackViewSpacing = 5.0
        static let topValue = 10.0
        static let bottomValue = -10.0
        static let leadingValue = 10.0
        static let trailingValue = -10.0
    }
    
    var viewModel: CellViewModel? {
        didSet {
            setupBind()
        }
    }
    
    let titleLabel = UILabel(fontStyle: .title3)
    let descriptionLabel = UILabel(fontStyle: .body)
    let dateLabel = UILabel(fontStyle: .body)
    
    private lazy var stackView = UIStackView(
        views: [titleLabel, descriptionLabel, dateLabel],
        axis: .vertical,
        alignment: .leading,
        distribution: .fill,
        spacing: UIConstant.stackViewSpacing
    )
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLabel()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .white
        contentView.bounds = contentView.bounds.inset(
            by: UIEdgeInsets(top: .zero, left: .zero, bottom: 5, right: .zero)
        )
    }
    
    override func prepareForReuse() {
        [titleLabel, descriptionLabel, dateLabel].forEach {
            $0.text = ""
        }
    }
    
    private func setupBind() {
        viewModel?.bindDate { [weak self] data in
            guard let data = data else { return }
            self?.titleLabel.text = data.title
            self?.descriptionLabel.text = data.content
            self?.dateLabel.text = data.convertDeadline
        }
    }
}

// MARK: - UI Configuration
extension ProcessTableViewCell {
    private func setupView() {
        backgroundColor = .systemGray5
        contentView.addSubview(stackView)
    }
    
    private func setupLabel() {
        titleLabel.numberOfLines = UIConstant.titleNumberLine
        descriptionLabel.numberOfLines = UIConstant.descriptionNumberLine
    }
    
    private func setupConstraint() {
        let safeArea = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: safeArea.topAnchor,
                constant: UIConstant.topValue
            ),
            stackView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: UIConstant.leadingValue
            ),
            stackView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor,
                constant: UIConstant.trailingValue
            ),
            stackView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: UIConstant.bottomValue
            )
        ])
    }
}

extension ProcessTableViewCell: IdentifierUsable { }
