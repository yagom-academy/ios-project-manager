//
//  ItemTableViewCell.swift
//  ProjectManager
//
//  Created by 이영우 on 2021/07/22.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    private enum Style {
        static let margin: UIEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    static let identifier = "itemTableViewCell"
    private var titleLabel: UILabel = UILabel()
    private var contentLabel: UILabel = UILabel()
    private var dateLabel: UILabel = UILabel()
    
    lazy var stackView: UIStackView = {
        let stackView: UIStackView = UIStackView(arrangedSubviews: [titleLabel, contentLabel, dateLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(stackView)
        configureConstraints()
        configureTitleLabel()
        configureContentLabel()
        configureDateLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            self.backgroundColor = .systemGray
        } else {
            self.backgroundColor = .systemBackground
        }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Style.margin.left),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Style.margin.top),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Style.margin.right),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Style.margin.bottom)
        ])
    }
    
    func configure(task: Task) {
        let deadLineText = DateUtil.formatDate(Date(timeIntervalSince1970: task.deadLine))
        titleLabel.text = task.title
        contentLabel.text = task.content
        dateLabel.text = deadLineText
        if task.type != .done {
            let currentDate = DateUtil.formatDate(Date())
            if currentDate <= deadLineText {
                dateLabel.textColor = .black
            } else {
                dateLabel.textColor = .systemRed
            }
        }
    }
}

extension ItemTableViewCell {
    
    private func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 1
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
    }
    
    private func configureContentLabel() {
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.numberOfLines = 3
        contentLabel.lineBreakMode = .byTruncatingTail
        contentLabel.font = UIFont.preferredFont(forTextStyle: .body)
        contentLabel.textColor = .systemGray2
    }
    
    private func configureDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.numberOfLines = 1
        dateLabel.lineBreakMode = .byTruncatingTail
        dateLabel.font = UIFont.preferredFont(forTextStyle: .callout)
    }
}

