//
//  TaskCell.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 06/07/2022.
//

import UIKit

final class TaskCell: UITableViewCell {
    
    // MARK: UIComponents - StackView
    
    private lazy var baseStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, bodyLabel, dateLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.axis = .vertical
        
        return stackView
    }()
    
    // MARK: UIComponents - UILabel
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.setContentHuggingPriority(.defaultHigh+1, for: .vertical)
        label.numberOfLines = 3
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.setContentHuggingPriority(.defaultHigh+2, for: .vertical)
        return label
    }()
    
    // MARK: initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(baseStackView)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Cell life cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        bodyLabel.text = ""
        dateLabel.text = ""
    }
    
    // MARK: functions
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            baseStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            baseStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            baseStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            baseStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func setUpLabel(task: Task) {
        self.titleLabel.text = task.title
        self.bodyLabel.text = task.body
        self.dateLabel.text = task.date.formattedString
        setDateLabelColor(date: task.date)
    }
    
    func setDateLabelColor(date: Date) {
        let result = date.compare(Date())
        switch result {
        case .orderedAscending:
            dateLabel.textColor = .red
        default:
            dateLabel.textColor = .black
        }
    }
}
