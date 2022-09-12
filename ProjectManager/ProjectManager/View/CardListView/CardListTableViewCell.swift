//
//  CardListTableViewCell.swift
//  ProjectManager
//
//  Created by Derrick kim on 9/7/22.
//

import UIKit
import Then

final class CardListTableViewCell: BaseTableViewCell<TodoListModel> {
    static let identifier = "CardListTableViewCell"
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont.preferredFont(forTextStyle: .title3)
        $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    private let descriptionLabel = UILabel().then {
        $0.font = UIFont.preferredFont(forTextStyle: .body)
        $0.textColor = .systemGray3
        $0.numberOfLines = 3
    }
    
    private let deadlineDateLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .callout)
        $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    private lazy var rootStackView = UIStackView(
        arrangedSubviews: [titleLabel, descriptionLabel, deadlineDateLabel]).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.distribution = .fill
        $0.alignment = .fill
        $0.axis = .vertical
        $0.spacing = 4
    }
        
    override func configure() {
        super.configure()

        self.backgroundColor = .secondarySystemBackground
        self.contentView.layer.cornerRadius = 8
        self.contentView.addSubview(rootStackView)
        
        configureLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        descriptionLabel.text = nil
        deadlineDateLabel.text = nil
        backgroundColor = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layer.addBottomBorder()
    }
    
    override func bind(_ model: TodoListModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        deadlineDateLabel.text = model.deadlineDate.description
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }
}
