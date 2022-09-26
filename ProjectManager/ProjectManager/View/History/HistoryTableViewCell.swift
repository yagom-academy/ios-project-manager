//
//  HistoryTableViewCell.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/23.
//

import UIKit

final class HistoryTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "HistoryTableViewCell"
    
    private let historyTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private let timestampLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Methods
    private func setupView() {
        addSubView()
        setupConstraints()
    }
    
    private func addSubView() {
        verticalStackView.addArrangedSubview(historyTitleLabel)
        verticalStackView.addArrangedSubview(timestampLabel)

        self.contentView.addSubview(verticalStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            verticalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            verticalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            verticalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])
    }
    
    func configure(with history: String) {
        historyTitleLabel.text = history
        timestampLabel.text = Date().convertToRegion(timeStyle: .medium)
    }
}
