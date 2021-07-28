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
    lazy var titleLabel: ItemTitleLabel = ItemTitleLabel()
    lazy var contentLabel: ItemContentLabel = ItemContentLabel()
    lazy var dateLabel: ItemDateLabel = ItemDateLabel()
    
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
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Style.margin.right),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Style.margin.bottom)
        ])
    }
    
    func configure(task: Task) {
        titleLabel.text = task.title
        contentLabel.text = task.content
        dateLabel.text = task.deadLine
        if task.state != .done {
            dateLabel.setTextColor(by: task.deadLine)
        }
    }
}
