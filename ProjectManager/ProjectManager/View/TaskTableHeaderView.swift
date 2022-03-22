//
//  TaskTableHeaderView.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/10.
//

import UIKit

private enum Design {
    static let taskCountLabelBounds = CGRect(origin: .zero, size: CGSize(width: 30, height: 30))
    
    static let titleLeadingMargin: CGFloat = 10
    static let titleTopMargin: CGFloat = 10
    static let titleBottomMargin: CGFloat = -10
}

final class TaskTableHeaderView: UITableViewHeaderFooterView {
    private let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    private let taskCountLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.textAlignment = .center
        label.bounds = Design.taskCountLabelBounds
        label.layer.cornerRadius = Design.taskCountLabelBounds.size.width / 2
        label.layer.masksToBounds = true
        label.textColor = .systemBackground
        label.backgroundColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureLayout() {
        [titleLabel, taskCountLabel].forEach {
            headerStackView.addArrangedSubview($0)
        }
        
        contentView.addSubview(headerStackView)
        
        NSLayoutConstraint.activate([
            taskCountLabel.widthAnchor.constraint(equalToConstant: Design.taskCountLabelBounds.width),
            taskCountLabel.heightAnchor.constraint(equalTo: taskCountLabel.widthAnchor),
            headerStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Design.titleLeadingMargin),
            headerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Design.titleBottomMargin)
        ])
    }
    
    func configureUI(state: TaskState, count: Int) {
        titleLabel.text = state.title
        taskCountLabel.text = count.description
    }
}
