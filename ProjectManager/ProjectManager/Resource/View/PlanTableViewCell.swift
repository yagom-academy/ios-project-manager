//
//  PlanTableViewCell.swift
//  ProjectManager
//
//  Created by 로빈솜 on 2023/01/11.
//

import UIKit

final class PlanTableViewCell: UITableViewCell {
    // MARK: Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = .preferredFont(forTextStyle: .caption1)
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()

    private let deadlineLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption2)
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 4
        return stackView
    }()

    // MARK: Initialization
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureLayout()
    }

    // TODO: 마감일 지나면 빨간색으로 표시해주는 부분 수정해야함
    func configureCell(with todo: Plan) {
        self.titleLabel.text = todo.title
        self.descriptionLabel.text = todo.description
        self.deadlineLabel.text = DateFormatterManager.formatDate(todo.deadline)

        guard let validate = DateFormatterManager.isExpiredDate(todo.deadline) else { return }

        if validate {
            deadlineLabel.textColor = .red
        } else if todo.status == .done {
            return
        }
    }

    // MARK: Private Method
    private func configureLayout() {
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(deadlineLabel)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
}

extension PlanTableViewCell: CellReusable { }
