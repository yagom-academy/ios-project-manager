//
//  WorkTableViewCell.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/07.
//

import UIKit

final class WorkTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "WorkTableViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .systemGray
        label.numberOfLines = 3
        return label
    }()
    
    private let deadlineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption1)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        deadlineLabel.textColor = .black
    }
    
    // MARK: - Methods
    private func setupView() {
        addSubView()
        setupConstraints()
        self.selectionStyle = .none
    }
    
    private func addSubView() {
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(contentLabel)
        verticalStackView.addArrangedSubview(deadlineLabel)

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
    
    func configure(with work: Work) {
        titleLabel.text = work.title
        contentLabel.text = work.content
        deadlineLabel.text = work.deadline.convertToRegion()
       
        if DateManager().checkOverdue(date: work.deadline) {
            self.deadlineLabel.textColor = .systemRed
        }
    }
}
