//
//  ItemTableViewCell.swift
//  ProjectManager
//
//  Created by 이영우 on 2021/07/22.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
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
