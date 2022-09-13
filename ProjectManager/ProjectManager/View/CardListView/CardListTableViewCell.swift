//
//  CardListTableViewCell.swift
//  ProjectManager
//
//  Created by Derrick kim on 9/7/22.
//

import UIKit
import Then

final class CardListTableViewCell: UITableViewCell, ReuseIdentifying {
    private enum Const {
        static let stackViewSpacing = 12.0
        static let baseConstraint = 12.0
        static let layerCornerRadius = 30.0
        static let numberOfLines = 3
    }
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont.preferredFont(forTextStyle: .title3)
        $0.setContentHuggingPriority(.defaultHigh,
                                     for: .vertical)
    }
    
    private let descriptionLabel = UILabel().then {
        $0.font = UIFont.preferredFont(forTextStyle: .body)
        $0.textColor = .systemGray3
        $0.numberOfLines = Const.numberOfLines
    }
    
    private let deadlineDateLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .callout)
        $0.setContentHuggingPriority(.defaultHigh,
                                     for: .vertical)
    }
    
    private lazy var rootStackView = UIStackView(
        arrangedSubviews: [titleLabel, descriptionLabel, deadlineDateLabel]).then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.axis = .vertical
            $0.spacing = Const.stackViewSpacing
        }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupDefault()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        descriptionLabel.text = nil
        deadlineDateLabel.text = nil
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
    
    private func setupDefault() {
        self.contentView.addSubview(rootStackView)
        
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor,
                                               constant: Const.baseConstraint),
            rootStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
                                                  constant: -Const.baseConstraint),
            rootStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
                                                   constant: Const.baseConstraint),
            rootStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
                                                    constant: -Const.baseConstraint)
        ])
    }
}
